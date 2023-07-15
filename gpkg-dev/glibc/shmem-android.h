/* <shmem-android.h> - dependencies (values ​​and commands) for system V shared
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

#ifndef __SHMEM_ANDROID
#define __SHMEM_ANDROID

#include <sys/socket.h>
#include <sys/un.h>
#include <paths.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <stdio.h>

#define __u32 uint32_t

#ifdef ENABLE_DEBUG_SHMEM_ANDROID
# define DBG(...) printf(__VA_ARGS__)
#else
# define DBG(...)
#endif //ENABLE_DEBUG_SHMEM_ANDROID

#define __ASHMEMIOC 0x77
#define ASHMEM_NAME_LEN 256
#define ASHMEM_GET_SIZE _IO(__ASHMEMIOC, 4)
#define ASHMEM_SET_SIZE _IOW(__ASHMEMIOC, 3, size_t)
#define ASHMEM_SET_NAME _IOW(__ASHMEMIOC, 1, char[ASHMEM_NAME_LEN])

#define ASHV_KEY_SYMLINK_PATH _PATH_TMP "ashv_key_%d"
#define ANDROID_SHMEM_SOCKNAME "/dev/shm/%08x"
#define ROUND_UP(N, S) ((((N) + (S) - 1) / (S)) * (S))

typedef struct {
	int id;
	void *addr;
	int descriptor;
	size_t size;
	bool markedForDeletion;
	key_t key;
} shmem_t;

static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;

static shmem_t* shmem = NULL;
static size_t shmem_amount = 0;
static int ashv_local_socket_id = 0;
static int ashv_pid_setup = 0;
static pthread_t ashv_listening_thread_id = 0;

static int ancil_send_fd(int sock, int fd)
{
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

static int ancil_recv_fd(int sock)
{
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

static int ashmem_get_size_region(int fd)
{
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
static int ashmem_create_region(char const* name, size_t size)
{
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

static void ashv_check_pid()
{
	pid_t mypid = getpid();
	if (ashv_pid_setup == 0) {
		ashv_pid_setup = mypid;
	} else if (ashv_pid_setup != mypid) {
		DBG("%s: Cleaning to new pid=%d from oldpid=%d", __PRETTY_FUNCTION__, mypid, ashv_pid_setup);
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
static int ashv_shmid_from_counter(unsigned int counter)
{
	return ashv_local_socket_id * 0x10000 + counter;
}

static int ashv_socket_id_from_shmid(int shmid)
{
	return shmid / 0x10000;
}

static int ashv_find_local_index(int shmid)
{
	for (size_t i = 0; i < shmem_amount; i++)
		if (shmem[i].id == shmid)
			return i;
	return -1;
}

static void* ashv_thread_function(void* arg)
{
	int sock = *(int*)arg;
	free(arg);
	struct sockaddr_un addr;
	socklen_t len = sizeof(addr);
	int sendsock;
	DBG("%s: thread started", __PRETTY_FUNCTION__);
	while ((sendsock = accept(sock, (struct sockaddr *)&addr, &len)) != -1) {
		int shmid;
		if (recv(sendsock, &shmid, sizeof(shmid), 0) != sizeof(shmid)) {
			DBG("%s: ERROR: recv() returned not %zu bytes", __PRETTY_FUNCTION__, sizeof(shmid));
			close(sendsock);
			continue;
		}
		pthread_mutex_lock(&mutex);
		int idx = ashv_find_local_index(shmid);
		if (idx != -1) {
			if (write(sendsock, &shmem[idx].key, sizeof(key_t)) != sizeof(key_t)) {
				DBG("%s: ERROR: write failed: %s", __PRETTY_FUNCTION__, strerror(errno));
			}
			if (ancil_send_fd(sendsock, shmem[idx].descriptor) != 0) {
				DBG("%s: ERROR: ancil_send_fd() failed: %s", __PRETTY_FUNCTION__, strerror(errno));
			}
		} else {
			DBG("%s: ERROR: cannot find shmid 0x%x", __PRETTY_FUNCTION__, shmid);
		}
		pthread_mutex_unlock(&mutex);
		close(sendsock);
		len = sizeof(addr);
	}
	DBG ("%s: ERROR: listen() failed, thread stopped", __PRETTY_FUNCTION__);
	return NULL;
}

static void android_shmem_delete(int idx)
{
	if (shmem[idx].descriptor) close(shmem[idx].descriptor);
	shmem_amount--;
	memmove(&shmem[idx], &shmem[idx+1], (shmem_amount - idx) * sizeof(shmem_t));
}

static int ashv_read_remote_segment(int shmid)
{
	struct sockaddr_un addr;
	memset(&addr, 0, sizeof(addr));
	addr.sun_family = AF_UNIX;
	sprintf(&addr.sun_path[1], ANDROID_SHMEM_SOCKNAME, ashv_socket_id_from_shmid(shmid));
	int addrlen = sizeof(addr.sun_family) + strlen(&addr.sun_path[1]) + 1;

	int recvsock = socket(AF_UNIX, SOCK_STREAM, 0);
	if (recvsock == -1) {
		DBG ("%s: cannot create UNIX socket: %s", __PRETTY_FUNCTION__, strerror(errno));
		return -1;
	}
	if (connect(recvsock, (struct sockaddr*) &addr, addrlen) != 0) {
		DBG("%s: Cannot connect to UNIX socket %s: %s, len %d", __PRETTY_FUNCTION__, addr.sun_path + 1, strerror(errno), addrlen);
		close(recvsock);
		return -1;
	}

	if (send(recvsock, &shmid, sizeof(shmid), 0) != sizeof(shmid)) {
		DBG ("%s: send() failed on socket %s: %s", __PRETTY_FUNCTION__, addr.sun_path + 1, strerror(errno));
		close(recvsock);
		return -1;
	}

	key_t key;
	if (read(recvsock, &key, sizeof(key_t)) != sizeof(key_t)) {
		DBG("%s: ERROR: failed read", __PRETTY_FUNCTION__);
		close(recvsock);
		return -1;
	}

	int descriptor = ancil_recv_fd(recvsock);
	if (descriptor < 0) {
		DBG("%s: ERROR: ancil_recv_fd() failed on socket %s: %s", __PRETTY_FUNCTION__, addr.sun_path + 1, strerror(errno));
		close(recvsock);
		return -1;
	}
	close(recvsock);

	int size = ashmem_get_size_region(descriptor);
	if (size == 0 || size == -1) {
		DBG ("%s: ERROR: ashmem_get_size_region() returned %d on socket %s: %s", __PRETTY_FUNCTION__, size, addr.sun_path + 1, strerror(errno));
		return -1;
	}

	int idx = shmem_amount;
	shmem_amount ++;
	shmem = realloc(shmem, shmem_amount * sizeof(shmem_t));
	shmem[idx].id = shmid;
	shmem[idx].descriptor = descriptor;
	shmem[idx].size = size;
	shmem[idx].addr = NULL;
	shmem[idx].markedForDeletion = false;
	shmem[idx].key = key;
	return idx;
}

#endif /* __SHMEM_ANDROID */
