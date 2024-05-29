#include <errno.h>
#include <unistd.h>
#include <setxid.h>
#include <fakesyscall.h>

int setfsuid(uid_t fsuid) {
	return syscall (__NR_setfsuid, fsuid);
}
