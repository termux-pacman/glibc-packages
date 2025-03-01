#ifndef __SHMEM_ANDROID
#define __SHMEM_ANDROID

#include <sys/socket.h>
#include <sys/un.h>
#include <paths.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <sys/shm.h>
#include <unistd.h>
#include <stdio.h>
#include <stdio_ext.h>
#include <pthread.h>
#include <ipc_priv.h>
#include <stdlib.h>
#include <errno.h>
#include <stdbool.h>
#include <signal.h>

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

#define ASHV_RM 0
#define ASHV_GET 1
#define ASHV_AT 2
#define ASHV_DT 3
#define ASHV_UPD 4

typedef struct {
	int id;
	void *addr;
	int descriptor;
	size_t size;
	bool markedForDeletion;
	key_t key;
	int countAttach;
	pid_t *attachedPids;
} shmem_t;

extern pthread_mutex_t mutex;
extern shmem_t* shmem;
extern size_t shmem_amount;
extern int ashv_local_socket_id;
extern pid_t ashv_pid_setup;
extern pthread_t ashv_listening_thread_id;

// PS: some functions are not available for including because they are used only inside shmem-android
//extern int ancil_send_fd(int sock, int fd) __THROW;
//libc_hidden_proto(ancil_send_fd)
//extern int ancil_recv_fd(int sock) __THROW;
//libc_hidden_proto(ancil_recv_fd)
//extern int ashmem_get_size_region(int fd) __THROW;
//libc_hidden_proto(ashmem_get_size_region)

extern int ashmem_create_region(char const* name, size_t size) __THROW;
libc_hidden_proto(ashmem_create_region)

extern void ashv_check_pid(void) __THROW;
libc_hidden_proto(ashv_check_pid)

extern int ashv_shmid_from_counter(unsigned int counter) __THROW;
libc_hidden_proto(ashv_shmid_from_counter)

extern int ashv_socket_id_from_shmid(int shmid) __THROW;
libc_hidden_proto(ashv_socket_id_from_shmid)

extern int ashv_find_local_index(int shmid) __THROW;
libc_hidden_proto(ashv_find_local_index)

extern void* ashv_thread_function(void* arg) __THROW;
libc_hidden_proto(ashv_thread_function)

extern void android_shmem_attach_pid(int idx, pid_t pid) __THROW;
libc_hidden_proto(android_shmem_attach_pid)

extern void android_shmem_detach_pid(int idx, pid_t pid) __THROW;
libc_hidden_proto(android_shmem_detach_pid)

extern void android_shmem_delete(int idx) __THROW;
libc_hidden_proto(android_shmem_delete)

extern void android_shmem_check_pids(int idx) __THROW;
libc_hidden_proto(android_shmem_check_pids)

extern void ashv_delete_segment(int idx) __THROW;
libc_hidden_proto(ashv_delete_segment)

extern int ashv_read_remote_segment(int shmid) __THROW;
libc_hidden_proto(ashv_read_remote_segment)

extern int ashv_delete_remote_segment(int shmid) __THROW;
libc_hidden_proto(ashv_delete_remote_segment)

extern int ashv_attach_remote_segment(int shmid) __THROW;
libc_hidden_proto(ashv_attach_remote_segment)

extern int ashv_detach_remote_segment(int shmid) __THROW;
libc_hidden_proto(ashv_detach_remote_segment)

extern int ashv_get_update_remote_segment(int idx) __THROW;
libc_hidden_proto(ashv_get_update_remote_segment)

#define INIT_SHMEM(ret_err) \
	int socket_id = ashv_socket_id_from_shmid(shmid); \
	int idx = ashv_find_local_index(shmid); \
	if (idx == -1 && socket_id != ashv_local_socket_id) \
		idx = ashv_read_remote_segment(shmid); \
	if (idx == -1) { \
		DBG ("%s: ERROR: shmid %x does not exist\n", __PRETTY_FUNCTION__, shmid); \
		pthread_mutex_unlock(&mutex); \
		errno = EINVAL; \
		return ret_err; \
	} \
	if (socket_id != ashv_local_socket_id) \
		ashv_get_update_remote_segment(idx); \
	else \
		android_shmem_check_pids(idx); \
	if (shmem[idx].markedForDeletion && shmem[idx].countAttach == 0) { \
		DBG ("%s: shmid %d marked for deletion, it will be deleted\n", __PRETTY_FUNCTION__, shmid); \
		android_shmem_delete(idx); \
		pthread_mutex_unlock(&mutex); \
		errno = EINVAL; \
		return ret_err; \
	}

#endif /* __SHMEM_ANDROID */
