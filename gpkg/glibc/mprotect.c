/* - Fix for Termux
   If you run mprotect with the PROT_EXEC flag,
   then the error "Permission denied" is displayed.

   Cause: https://github.com/termux/proot/commit/89bfa991cb3cb7fc78099d06d0f7e7c840cb62d1
   Issue: https://github.com/termux-pacman/glibc-packages/issues/49
   Solution: https://stackoverflow.com/questions/59303617/c-mprotect-for-read-write-and-execute
*/

#include <errno.h>
#include <sys/mman.h>
#include <sysdep.h>
#include <sys/syscall.h>
#include <string.h>
#include <fcntl.h>
#include <stdio.h>
#include <not-cancel.h>

#ifdef SHARED
# define GLOBAL_READ_SIZE 45

/* - String To Unsigned Long Int
   There are two chairs - one is called "strtoul", the other "stuli"...
*/
unsigned long int __stuli(char *value) {
	unsigned long int val, res = 0;
	int len = strlen(value);

	for (int i=0; i<len; i++) {
		val = value[len-1-i]-'0';
		if (val == 0)
			continue;
		else if (val > 9)
			val = value[len-1-i]-'W';
		for (int j=0; j<i; j++)
			val *= 16;
		res += val;
	}

	return res;
}

static int __is_mmaped(void *addr) {
	char buff[GLOBAL_READ_SIZE];
	char *buff2;
	char maddr[GLOBAL_READ_SIZE*2];
	memset(maddr, 0, sizeof(maddr));

	int skip = 0;
	int res = 1;

	int map = __open_nocancel("/proc/self/maps", O_RDONLY|O_CLOEXEC);
	if (map >= 0) {
		while (__read_nocancel(map, buff, GLOBAL_READ_SIZE) == GLOBAL_READ_SIZE) {
			buff[GLOBAL_READ_SIZE] = '\0';
			if (skip == 1)
				if ((buff2=strrchr(buff, '\n')) != NULL)
					memcpy(maddr, &buff2[1], strlen(&buff2[1])+1);
				else
					continue;
			if (strrchr(maddr, '-') == NULL) {
				if (skip == 1) {
					skip = 0;
					continue;
				}
				strncat(maddr, buff, GLOBAL_READ_SIZE);
			}
			if (__stuli(strtok(maddr, "-")) == (unsigned long int)addr) {
				res = 0;
				break;
			}
			memset(maddr, 0, sizeof(maddr));
			if ((buff2=strrchr(buff, '\n')) != NULL)
				memcpy(maddr, &buff2[1], strlen(&buff2[1])+1);
			else
				skip = 1;
		}
		__close_nocancel_nostatus(map);
	}

	return res;
}
#endif

int __mprotect(void *addr, size_t len, int prot) {
	int res = INLINE_SYSCALL_CALL(mprotect, addr, len, prot);
#ifdef SHARED
	if (res == -1 && errno == EACCES && prot & PROT_EXEC && __is_mmaped(addr) == 1) {
		size_t saddr = strlen(addr)+1;
		void *caddr;
		if (saddr > 1) {
			caddr = malloc(saddr);
			memcpy(caddr, addr, saddr);
		}
		mmap(addr, len, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED, -1, 0);
		if (saddr > 1) {
			memcpy(addr, caddr, saddr);
			free(caddr);
		}
		return INLINE_SYSCALL_CALL(mprotect, addr, len, prot);
	}
#endif
	return res;
}

libc_hidden_def(__mprotect)
weak_alias(__mprotect, mprotect)
