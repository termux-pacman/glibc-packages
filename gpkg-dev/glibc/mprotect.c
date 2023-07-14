/* - Fix for Termux
   If you run mprotect with the PROT_EXEC flag,
   then the error "Permission denied" is displayed.

   Cause: https://stackoverflow.com/questions/41174549/mprotect-permission-denied-error-on-rhel-6-8
   Issue: https://github.com/termux-pacman/glibc-packages/issues/49
*/

#include <sys/mman.h>
#include <sysdep.h>

int
__mprotect (void *addr, size_t len, int prot)
{
  if (prot & PROT_EXEC)
    prot &= ~PROT_EXEC;

  return INLINE_SYSCALL_CALL (mprotect, addr, len, prot);
}

libc_hidden_def (__mprotect)
weak_alias (__mprotect, mprotect)
