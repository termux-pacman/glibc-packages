#ifndef __SHMEM_ANDROID
#define __SHMEM_ANDROID

#include <sys/socket.h>
#include <sys/un.h>
#include <paths.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <stdio.h>
#include <pthread.h>

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

extern pthread_mutex_t mutex;
extern shmem_t* shmem;
extern size_t shmem_amount;
extern int ashv_local_socket_id;
extern int ashv_pid_setup;
extern pthread_t ashv_listening_thread_id;

int ancil_send_fd(int sock, int fd);
int ancil_recv_fd(int sock);
int ashmem_get_size_region(int fd);
int ashmem_create_region(char const* name, size_t size);
void ashv_check_pid(void);
int ashv_shmid_from_counter(unsigned int counter);
int ashv_socket_id_from_shmid(int shmid);
int ashv_find_local_index(int shmid);
void* ashv_thread_function(void* arg);
void android_shmem_delete(int idx);
int ashv_read_remote_segment(int shmid);

#endif /* __SHMEM_ANDROID */
