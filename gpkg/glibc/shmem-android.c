/* <shmem-android.{h,c}> - dependencies (values ​​and commands) for system V shared
 * memory emulation on Android using ashmem. Needed in the following files:
 * - shmat.c
 * - shmctl.c
 * - shmdt.c
 * - shmget.c
 *
 * The code was taken from the libandroid-shmem repo:
 * <https://github.com/termux/libandroid-shmem>
 *
 * PS: it's adding libandroid-shmem to the glibc system with some modifications
 * to make it work on a glibc basis.
 */

#include <shmem-android.h>

pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
shmem_t* shmem = NULL;
size_t shmem_amount = 0;
int ashv_local_socket_id = 0;
pid_t ashv_pid_setup = 0;
pthread_t ashv_listening_thread_id = 0;

static int ancil_send_fd(int sock, int fd) {
	char nothing = '!';
	struct iovec nothing_ptr = { .iov_base = &nothing, .iov_len = 1 };

	struct {
		struct cmsghdr align;
		int fd[1];
	} ancillary_data_buffer;

	struct msghdr message_header = {
		.msg_name = NULL,
		.msg_namelen = 0,
		.msg_iov = &nothing_ptr,
		.msg_iovlen = 1,
		.msg_flags = 0,
		.msg_control = &ancillary_data_buffer,
		.msg_controllen = sizeof(struct cmsghdr) + sizeof(int)
	};

	struct cmsghdr* cmsg = CMSG_FIRSTHDR(&message_header);
	cmsg->cmsg_len = message_header.msg_controllen; // sizeof(int);
	cmsg->cmsg_level = SOL_SOCKET;
	cmsg->cmsg_type = SCM_RIGHTS;
	((int*) CMSG_DATA(cmsg))[0] = fd;

	return sendmsg(sock, &message_header, 0) >= 0 ? 0 : -1;
}

static int ancil_recv_fd(int sock) {
	char nothing = '!';
	struct iovec nothing_ptr = { .iov_base = &nothing, .iov_len = 1 };

	struct {
		struct cmsghdr align;
		int fd[1];
	} ancillary_data_buffer;

	struct msghdr message_header = {
		.msg_name = NULL,
		.msg_namelen = 0,
		.msg_iov = &nothing_ptr,
		.msg_iovlen = 1,
		.msg_flags = 0,
		.msg_control = &ancillary_data_buffer,
		.msg_controllen = sizeof(struct cmsghdr) + sizeof(int)
	};

	struct cmsghdr* cmsg = CMSG_FIRSTHDR(&message_header);
	cmsg->cmsg_len = message_header.msg_controllen;
	cmsg->cmsg_level = SOL_SOCKET;
	cmsg->cmsg_type = SCM_RIGHTS;
	((int*) CMSG_DATA(cmsg))[0] = -1;

	if (recvmsg(sock, &message_header, 0) < 0) return -1;

	return ((int*) CMSG_DATA(cmsg))[0];
}

static int ashmem_get_size_region(int fd) {
	//int ret = __ashmem_is_ashmem(fd, 1);
	//if (ret < 0) return ret;
	return TEMP_FAILURE_RETRY(ioctl(fd, ASHMEM_GET_SIZE, NULL));
}

/*
 * From https://android.googlesource.com/platform/system/core/+/master/libcutils/ashmem-dev.c
 *
 * ashmem_create_region - creates a new named ashmem region and returns the file
 * descriptor, or <0 on error.
 *
 * `name' is the label to give the region (visible in /proc/pid/maps)
 * `size' is the size of the region, in page-aligned bytes
 */
int ashmem_create_region(char const* name, size_t size) {
	int fd = open("/dev/ashmem", O_RDWR);
	if (fd < 0) return fd;

	char name_buffer[ASHMEM_NAME_LEN] = {0};
	strncpy(name_buffer, name, sizeof(name_buffer));
	name_buffer[sizeof(name_buffer)-1] = 0;

	int ret = ioctl(fd, ASHMEM_SET_NAME, name_buffer);
	if (ret < 0) goto error;

	ret = ioctl(fd, ASHMEM_SET_SIZE, size);
	if (ret < 0) goto error;

	return fd;
error:
	close(fd);
	return ret;
}

void ashv_check_pid(void) {
	pid_t mypid = getpid();
	if (ashv_pid_setup == 0)
		ashv_pid_setup = mypid;
	else if (ashv_pid_setup != mypid) {
		DBG("%s: Cleaning to new pid=%d from oldpid=%d\n", __PRETTY_FUNCTION__, mypid, ashv_pid_setup);
		// We inherited old state across a fork.
		ashv_pid_setup = mypid;
		ashv_local_socket_id = 0;
		ashv_listening_thread_id = 0;
		shmem_amount = 0;
		// Unlock if fork left us with held lock from parent thread.
		pthread_mutex_unlock(&mutex);
		if (shmem != NULL) free(shmem);
		shmem = NULL;
	}
}


// Store index in the lower 15 bits and the socket id in the
// higher 16 bits.
int ashv_shmid_from_counter(unsigned int counter) {
	return ashv_local_socket_id * 0x10000 + counter;
}

int ashv_socket_id_from_shmid(int shmid) {
	return shmid / 0x10000;
}

int ashv_find_local_index(int shmid) {
	for (size_t i = 0; i < shmem_amount; i++)
		if (shmem[i].id == shmid)
			return i;
	return -1;
}

#define SOCKET_ASHV_WRITE(type, var) \
	if (write(sendsock, &shmem[idx].var, sizeof(type)) != sizeof(type)) { \
		DBG("%s: ERROR: write %s failed: %s\n", __PRETTY_FUNCTION__, #var, strerror(errno)); \
		break; \
	}

#define SOCKET_ASHV_READ(type, var) \
	if (read(sendsock, &var, sizeof(type)) != sizeof(type)) { \
		DBG("%s: ERROR: read %s failed: %s\n", __PRETTY_FUNCTION__, #var, strerror(errno)); \
		break; \
	}

static int ashv_write_pids(int sendsock, int idx) {
	if (shmem[idx].countAttach > 0) {
		pid_t pids[shmem[idx].countAttach];
		for (int i=0; i<shmem[idx].countAttach; i++)
			pids[i] = shmem[idx].attachedPids[i];
		if (write(sendsock, &pids, sizeof(pids)) != sizeof(pids)) {
			DBG("%s: ERROR: write pids failed: %s\n", __PRETTY_FUNCTION__, strerror(errno));
			return -1;
		}
	}
	return 0;
}

void* ashv_thread_function(void* arg) {
	int sock = *(int*)arg;
	free(arg);
	struct sockaddr_un addr;
	socklen_t len = sizeof(addr);
	int sendsock;
	DBG("%s: thread started\n", __PRETTY_FUNCTION__);
	while ((sendsock = accept(sock, (struct sockaddr *)&addr, &len)) != -1) {
		int shmid;
		if (recv(sendsock, &shmid, sizeof(shmid), 0) != sizeof(shmid)) {
			DBG("%s: ERROR: recv() returned not %zu shmid bytes\n", __PRETTY_FUNCTION__, sizeof(shmid));
			close(sendsock);
			continue;
		}
		int action;
		if (recv(sendsock, &action, sizeof(action), 0) != sizeof(action)) {
			DBG("%s: ERROR: recv() returned not %zu action bytes\n", __PRETTY_FUNCTION__, sizeof(action));
			close(sendsock);
			continue;
		}
		pthread_mutex_lock(&mutex);
		int idx = ashv_find_local_index(shmid);
		if (idx != -1) {
			pid_t pid;
			switch (action) {
			case ASHV_RM:
				DBG("%s: action ASHV_RM(%d) for %d\n", __PRETTY_FUNCTION__, action, shmid);
				ashv_delete_segment(idx);
				break;
			case ASHV_GET:
				DBG("%s: action ASHV_GET(%d) for %d\n", __PRETTY_FUNCTION__, action, shmid);
				SOCKET_ASHV_WRITE(key_t, key)
				SOCKET_ASHV_WRITE(bool, markedForDeletion)
				SOCKET_ASHV_WRITE(int, countAttach)
				if (ancil_send_fd(sendsock, shmem[idx].descriptor) != 0)
					DBG("%s: ERROR: ancil_send_fd() failed: %s\n", __PRETTY_FUNCTION__, strerror(errno));
				break;
			case ASHV_AT:
				DBG("%s: action ASHV_AT(%d) for %d\n", __PRETTY_FUNCTION__, action, shmid);
				SOCKET_ASHV_READ(pid_t, pid)
				android_shmem_attach_pid(idx, pid);
				break;
			case ASHV_DT:
				DBG("%s: action ASHV_DT(%d) for %d\n", __PRETTY_FUNCTION__, action, shmid);
				SOCKET_ASHV_READ(pid_t, pid)
				android_shmem_detach_pid(idx, pid);
				break;
			case ASHV_UPD:
				DBG("%s: action ASHV_UPD(%d) for %d\n", __PRETTY_FUNCTION__, action, shmid);
				SOCKET_ASHV_WRITE(bool, markedForDeletion)
				android_shmem_check_pids(idx);
				SOCKET_ASHV_WRITE(int, countAttach)
				ashv_write_pids(sendsock, idx);
				break;
			default:
				DBG("%s: ERROR: unknown action %d\n", __PRETTY_FUNCTION__, action);
				break;
			}
		} else
			DBG("%s: ERROR: cannot find shmid 0x%x\n", __PRETTY_FUNCTION__, shmid);
		pthread_mutex_unlock(&mutex);
		close(sendsock);
		len = sizeof(addr);
	}
	DBG ("%s: ERROR: listen() failed, thread stopped\n", __PRETTY_FUNCTION__);
	return NULL;
}

void android_shmem_attach_pid(int idx, pid_t pid) {
	int idp = shmem[idx].countAttach;
	shmem[idx].countAttach++;
	shmem[idx].attachedPids = realloc(shmem[idx].attachedPids, shmem[idx].countAttach*sizeof(pid_t));
	shmem[idx].attachedPids[idp] = pid;
}

void android_shmem_detach_pid(int idx, pid_t pid) {
	for (int i=0; i<shmem[idx].countAttach; i++)
		if (shmem[idx].attachedPids[i] == pid) {
			shmem[idx].countAttach--;
			memmove(&shmem[idx].attachedPids[i], &shmem[idx].attachedPids[i+1], (shmem[idx].countAttach-i)*sizeof(pid_t));
			break;
	}
}

void android_shmem_check_pids(int idx) {
	for (int i=0; i<shmem[idx].countAttach; i++)
		if (kill(shmem[idx].attachedPids[i], 0) != 0) {
			DBG ("%s: process %d not found, removed from list\n", __PRETTY_FUNCTION__, shmem[idx].attachedPids[i]);
			shmem[idx].countAttach--;
			memmove(&shmem[idx].attachedPids[i], &shmem[idx].attachedPids[i+1], (shmem[idx].countAttach-i)*sizeof(pid_t));
			i--;
	}
}

void android_shmem_delete(int idx) {
	if (shmem[idx].descriptor) close(shmem[idx].descriptor);
	shmem_amount--;
	memmove(&shmem[idx], &shmem[idx+1], (shmem_amount - idx) * sizeof(shmem_t));
}

void ashv_delete_segment(int idx) {
	shmem[idx].markedForDeletion = true;
	if (shmem[idx].countAttach == 0)
		android_shmem_delete(idx);
}

static int ashv_read_pids(int recvsock, int idx) {
	if (shmem[idx].countAttach > 0) {
		pid_t pids[shmem[idx].countAttach];
		if (read(recvsock, &pids, sizeof(pids)) != sizeof(pids)) {
			DBG("%s: ERROR: read pids failed: %s\n", __PRETTY_FUNCTION__, strerror(errno));
			return -1;
		}
		shmem[idx].attachedPids = NULL;
		shmem[idx].attachedPids = realloc(shmem[idx].attachedPids, sizeof(pids));
		for (int i=0; i<shmem[idx].countAttach; i++)
			shmem[idx].attachedPids[i] = pids[i];
	} else
		shmem[idx].attachedPids = NULL;
	return 0;
}

static int ashv_connect_socket(struct sockaddr_un *addr, int shmid) {
	memset(addr, 0, sizeof(*addr));
	addr->sun_family = AF_UNIX;
	sprintf(&addr->sun_path[1], ANDROID_SHMEM_SOCKNAME, ashv_socket_id_from_shmid(shmid));
	int addrlen = sizeof(addr->sun_family) + strlen(&addr->sun_path[1]) + 1;

	int recvsock = socket(AF_UNIX, SOCK_STREAM, 0);
	if (recvsock == -1) {
		DBG ("%s: cannot create UNIX socket: %s\n", __PRETTY_FUNCTION__, strerror(errno));
		return -1;
	}
	if (connect(recvsock, (struct sockaddr*)addr, addrlen) != 0) {
		DBG("%s: Cannot connect to UNIX socket %s: %s, len %d\n", __PRETTY_FUNCTION__, addr->sun_path + 1, strerror(errno), addrlen);
		close(recvsock);
		return -1;
	}

	return recvsock;
}

static int ashv_send_shmid_action(int recvsock, struct sockaddr_un *addr, int shmid, int action) {
	if (send(recvsock, &shmid, sizeof(shmid), 0) != sizeof(shmid)) {
		DBG("%s: send shmid failed on socket %s: %s\n", __PRETTY_FUNCTION__, addr->sun_path + 1, strerror(errno));
		return -1;
	}
	if (send(recvsock, &action, sizeof(action), 0) != sizeof(action)) {
		DBG("%s: send action failed on socket %s: %s\n", __PRETTY_FUNCTION__, addr->sun_path + 1, strerror(errno));
		return -1;
	}
	return 0;
}

#define FUNC_ASHV_READ(type, var) \
	type var; \
	if (read(recvsock, &var, sizeof(type)) != sizeof(type)) { \
		DBG("%s: ERROR: read %s failed\n", __PRETTY_FUNCTION__, #var); \
		close(recvsock); \
		return -1; \
	}

int ashv_delete_remote_segment(int shmid) {
	struct sockaddr_un addr;
	int recvsock = ashv_connect_socket(&addr, shmid);
	if (recvsock == -1)
		return -1;

	int res = ashv_send_shmid_action(recvsock, &addr, shmid, ASHV_RM);

	close(recvsock);
	return res;
}

static int ashv_send_pid_remote_segment(int shmid, int action) {
	struct sockaddr_un addr;
	int recvsock = ashv_connect_socket(&addr, shmid);
	if (recvsock == -1)
		return -1;

	if (ashv_send_shmid_action(recvsock, &addr, shmid, action) == -1) {
		close(recvsock);
		return -1;
	}

	if (write(recvsock, &ashv_pid_setup, sizeof(pid_t)) != sizeof(pid_t)) {
		DBG("%s: ERROR: write pid failed\n", __PRETTY_FUNCTION__);
		close(recvsock);
		return -1;
        }

	close(recvsock);
	return 0;
}

int ashv_attach_remote_segment(int shmid) {
	return ashv_send_pid_remote_segment(shmid, ASHV_AT);
}

int ashv_detach_remote_segment(int shmid) {
	return ashv_send_pid_remote_segment(shmid, ASHV_DT);
}

int ashv_read_remote_segment(int shmid) {
	struct sockaddr_un addr;
	int recvsock = ashv_connect_socket(&addr, shmid);
	if (recvsock == -1)
		return -1;

	if (ashv_send_shmid_action(recvsock, &addr, shmid, ASHV_GET) == -1) {
		close(recvsock);
		return -1;
	}

	FUNC_ASHV_READ(key_t, key)
	FUNC_ASHV_READ(bool, markedForDeletion)
	FUNC_ASHV_READ(int, countAttach)

	if (markedForDeletion && countAttach == 0) {
		DBG("%s: shmid %d is marked for deletion so it is not passed\n", __PRETTY_FUNCTION__, shmid);
		close(recvsock);
		return -1;
	}

	int descriptor = ancil_recv_fd(recvsock);
	if (descriptor < 0) {
		DBG("%s: ERROR: ancil_recv_fd() failed on socket %s: %s\n", __PRETTY_FUNCTION__, addr.sun_path + 1, strerror(errno));
		close(recvsock);
		return -1;
	}
	close(recvsock);

	int size = ashmem_get_size_region(descriptor);
	if (size == 0 || size == -1) {
		DBG ("%s: ERROR: ashmem_get_size_region() returned %d on socket %s: %s\n", __PRETTY_FUNCTION__, size, addr.sun_path + 1, strerror(errno));
		return -1;
	}

	int idx = shmem_amount;
	shmem_amount ++;
	shmem = realloc(shmem, shmem_amount * sizeof(shmem_t));
	shmem[idx].id = shmid;
	shmem[idx].descriptor = descriptor;
	shmem[idx].size = size;
	shmem[idx].addr = NULL;
	shmem[idx].markedForDeletion = markedForDeletion;
	shmem[idx].key = key;
	shmem[idx].countAttach = countAttach;
	return idx;
}

int ashv_get_update_remote_segment(int idx) {
	int shmid = shmem[idx].id;
	struct sockaddr_un addr;
	int recvsock = ashv_connect_socket(&addr, shmid);
	if (recvsock == -1)
		goto removal;

	if (ashv_send_shmid_action(recvsock, &addr, shmid, ASHV_UPD) == -1) {
		close(recvsock);
		goto removal;
	}

	if (read(recvsock, &shmem[idx].markedForDeletion, sizeof(bool)) != sizeof(bool)) {
		close(recvsock);
		goto removal;
	}

	if (read(recvsock, &shmem[idx].countAttach, sizeof(int)) != sizeof(int)) {
		close(recvsock);
		goto removal;
	}

	if (ashv_read_pids(recvsock, idx) != 0) {
		close(recvsock);
		goto removal;
	}

	close(recvsock);
	return 0;
removal:
	DBG("%s: socket returned an error, shm %d will have a delete mark\n", __PRETTY_FUNCTION__, shmid);
	shmem[idx].countAttach = 0;
	shmem[idx].markedForDeletion = true;
	shmem[idx].attachedPids = NULL;
	if (shmem[idx].addr != NULL)
		android_shmem_attach_pid(idx, ashv_pid_setup);
	return -1;
}
