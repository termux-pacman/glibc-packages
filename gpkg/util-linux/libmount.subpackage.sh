TERMUX_SUBPKG_DESCRIPTION="Library for (un)mounting filesystems"
TERMUX_SUBPKG_DEPENDS="libblkid-glibc, libsmartcols-glibc"
TERMUX_SUBPKG_DEPEND_ON_PARENT="no"
TERMUX_SUBPKG_INCLUDE="
glibc/include/libmount/libmount.h
glibc/lib/libmount.so
glibc/lib/libmount.so.1
glibc/lib/libmount.so.1.1.0
glibc/lib/pkgconfig/mount.pc
"
