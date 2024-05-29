#ifndef _FAKE_SYSCALL
#define _FAKE_SYSCALL

#include <arch-syscall.h>
#include <disabled-syscall.h>
#include <fcntl.h>

// close_range
// fchownat
// ftruncate
// getpgrp
// unlinkat
// symlinkat
// faccessat
#include <unistd.h>

// accept4
// recvfrom
// sendto
#include <sys/socket.h>

// fchmodat
// statx
#include <sys/stat.h>

// __clock_gettime64
#include <time.h>

// epoll_pwait2
#include <sys/epoll.h>

// shmat
// shmctl
// shmdt
// shmget
#include <sys/shm.h>

#endif //_FAKE_SYSCALL
