TERMUX_SUBPKG_DESCRIPTION="Library for manipulating disk partition tables"
TERMUX_SUBPKG_DEPENDS="libblkid-glibc, libuuid-glibc"
TERMUX_SUBPKG_DEPEND_ON_PARENT="no"
TERMUX_SUBPKG_INCLUDE="
glibc/lib/pkgconfig/fdisk.pc
glibc/lib/libfdisk.so
glibc/lib/libfdisk.so.1
glibc/lib/libfdisk.so.1.1.0
glibc/include/libfdisk/libfdisk.h
"
