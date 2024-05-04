#ifndef _FAKE_SYSCALL
#define _FAKE_SYSCALL

#include <arch-syscall.h>
#include <disabled-syscall.h>

extern int close_range (unsigned int __fd, unsigned int __max_fd, int __flags) __THROW;

struct FakeSyscall {
	int id;
	long int (*func)(long int,
			 long int,
			 long int,
			 long int,
			 long int,
			 long int);
};

long int JustReturnZero() {
	return 0;
}

static struct FakeSyscall FakeSyscalls[] = {
	{ __NR_close_range, close_range },
	{ __NR_mbind, JustReturnZero },
	{ __NR_get_mempolicy, JustReturnZero },
	{ __NR_set_mempolicy, JustReturnZero },
	{ 1008, JustReturnZero }, // for some reason used in julia
};

#define CountFakeSyscalls (sizeof(FakeSyscalls) / sizeof(FakeSyscalls[0]))

#endif //_FAKE_SYSCALL
