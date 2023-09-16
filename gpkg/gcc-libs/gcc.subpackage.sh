TERMUX_SUBPKG_DESCRIPTION="The GNU Compiler Collection - C and C++ frontends, with Fortran front-end for GCC"
TERMUX_SUBPKG_DEPENDS="binutils-glibc, libmpc-glibc, zstd-glibc, libisl-glibc"
TERMUX_SUBPKG_INCLUDE="
glibc/bin/
glibc/include/c++/
glibc/lib/bfd-plugins/
glibc/lib/gcc/
glibc/lib/libasan_preinit.o
glibc/lib/liblsan_preinit.o
glibc/lib/libtsan_preinit.o
glibc/lib/*.spec
glibc/lib/libcc1.so*
glibc/lib/libstdc++*.a
glibc/lib/libsupc++*.a
glibc/share/gcc-*/
glibc/share/gdb/
glibc/share/info/
glibc/share/man/
"
