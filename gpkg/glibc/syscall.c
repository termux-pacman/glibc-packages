#include <stdarg.h>
#include <sysdep.h>
#include <fake-syscall.h>

extern long int syscallS (long int __sysno, ...) __THROW;

long int
syscall (long int number, ...)
{
  va_list args;
  va_start (args, number);
  long int a0 = va_arg (args, long int);
  long int a1 = va_arg (args, long int);
  long int a2 = va_arg (args, long int);
  long int a3 = va_arg (args, long int);
  long int a4 = va_arg (args, long int);
  long int a5 = va_arg (args, long int);
  va_end (args);

  for (int i=0; i<CountFakeSyscalls; ++i)
    if (FakeSyscalls[i].id == number)
      return FakeSyscalls[i].func(a0, a1, a2, a3, a4, a5);
  return syscallS (number, a0, a1, a2, a3, a4, a5);
}
