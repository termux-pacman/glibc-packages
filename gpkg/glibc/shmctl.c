#include <stdarg.h>
#include <ipc_priv.h>
#include <sysdep.h>
#include <shlib-compat.h>
#include <errno.h>
#include <shmem-android.h>
#include <asm-generic/ipcbuf.h>
#include <asm-generic/shmbuf.h>

#ifndef shmid_ds
# define shmid_ds shmid64_ds
#endif

int shmctl(int shmid, int cmd, struct shmid_ds *buf)
{
	ashv_check_pid();

	if (cmd == IPC_RMID) {
		DBG("%s: IPC_RMID for shmid=%x\n", __PRETTY_FUNCTION__, shmid);
		pthread_mutex_lock(&mutex);
		int idx = ashv_find_local_index(shmid);
		if (idx == -1) {
			DBG("%s: shmid=%x does not exist locally\n", __PRETTY_FUNCTION__, shmid);
			/* We do not rm non-local regions, but do not report an error for that. */
			pthread_mutex_unlock(&mutex);
			return 0;
		}

		if (shmem[idx].addr) {
			// shmctl(2): The segment will actually be destroyed only
			// after the last process detaches it (i.e., when the shm_nattch
			// member of the associated structure shmid_ds is zero.
			shmem[idx].markedForDeletion = true;
		} else {
			android_shmem_delete(idx);
		}
		pthread_mutex_unlock(&mutex);
		return 0;
	} else if (cmd == IPC_STAT) {
		if (!buf) {
			DBG ("%s: ERROR: buf == NULL for shmid %x\n", __PRETTY_FUNCTION__, shmid);
			errno = EINVAL;
			return -1;
		}

		pthread_mutex_lock(&mutex);
		int idx = ashv_find_local_index(shmid);
		if (idx == -1) {
			DBG ("%s: ERROR: shmid %x does not exist\n", __PRETTY_FUNCTION__, shmid);
			pthread_mutex_unlock (&mutex);
			errno = EINVAL;
			return -1;
		}
		/* Report max permissive mode */
		memset(buf, 0, sizeof(struct shmid_ds));
		buf->shm_segsz = shmem[idx].size;
		buf->shm_nattch = 1;
		buf->shm_perm.key = shmem[idx].key;
		buf->shm_perm.uid = geteuid();
		buf->shm_perm.gid = getegid();
		buf->shm_perm.cuid = geteuid();
		buf->shm_perm.cgid = getegid();
		buf->shm_perm.mode = 0666;
		buf->shm_perm.seq = 1;

		pthread_mutex_unlock (&mutex);
		return 0;
	}

	DBG("%s: cmd %d not implemented yet!\n", __PRETTY_FUNCTION__, cmd);
	errno = EINVAL;
	return -1;
}

weak_alias (shmctl, __shmctl64)
