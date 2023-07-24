/* - Fix for Termux
   If you run mprotect with the PROT_EXEC flag,
   then the error "Permission denied" is displayed.

   Cause: https://github.com/termux/proot/commit/89bfa991cb3cb7fc78099d06d0f7e7c840cb62d1
   Issue: https://github.com/termux-pacman/glibc-packages/issues/49
*/

#include <errno.h>
#include <sys/mman.h>
#include <sysdep.h>
#include <sys/syscall.h>
#include <string.h>

int __mprotect(void *addr, size_t len, int prot) {
#if !IS_IN(rtld)
	if (prot & PROT_EXEC) {
		void *caddr = malloc(len);
		if (caddr == NULL)
			return errno;
		memcpy(caddr, addr, len);
		addr = mmap(addr, len, prot, MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
		if (__glibc_unlikely(addr == MAP_FAILED))
			return errno;
		memcpy(addr, caddr, len);
		free(caddr);
		return 0;
	}
#endif
	return INLINE_SYSCALL_CALL(mprotect, addr, len, prot);
}

libc_hidden_def(__mprotect)
weak_alias(__mprotect, mprotect)
