#ifndef _FAKE_SYSCALL
#define _FAKE_SYSCALL

#include <arch-syscall.h>
#include <disabled-syscall.h>
#include <unistd.h>

#define _FIX(_name_func) (long int (*)(long int, \
				       long int, \
				       long int, \
				       long int, \
				       long int, \
				       long int))(&_name_func)

struct FakeSyscall {
	int id;
	long int (*func)(long int,
			 long int,
			 long int,
			 long int,
			 long int,
			 long int);
};

long int ReturnZero() {
	return 0;
}

long int ReturnENOSYS() {
	return INLINE_SYSCALL_ERROR_RETURN_VALUE(ENOSYS);
}

static struct FakeSyscall FakeSyscalls[] = {
	{ __NR_close_range, _FIX(close_range) },
	{ __NR_mbind, ReturnZero },
	{ __NR_set_robust_list, ReturnENOSYS },
	{ __NR_io_uring_setup, ReturnENOSYS },
	{ __NR_io_uring_enter, ReturnENOSYS },
	{ __NR_io_uring_register, ReturnENOSYS },
	{ __NR_get_mempolicy, ReturnZero },
	{ __NR_set_mempolicy, ReturnZero },
	{ 1008, ReturnZero }, // for some reason used in julia
};

#define CountFakeSyscalls (sizeof(FakeSyscalls) / sizeof(FakeSyscalls[0]))

#endif //_FAKE_SYSCALL
