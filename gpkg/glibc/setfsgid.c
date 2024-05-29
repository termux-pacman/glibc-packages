#include <errno.h>
#include <unistd.h>
#include <setxid.h>
#include <fakesyscall.h>

int setfsgid(uid_t fsgid) {
	return syscall (__NR_setfsgid, fsgid);
}
