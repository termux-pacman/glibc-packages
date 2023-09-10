TERMUX_SUBPKG_DESCRIPTION="Library for handling universally unique identifiers"
TERMUX_SUBPKG_DEPENDS="glibc"
TERMUX_SUBPKG_DEPEND_ON_PARENT="no"
TERMUX_SUBPKG_INCLUDE="
glibc/lib/pkgconfig/uuid.pc
glibc/lib/libuuid.so
glibc/lib/libuuid.so.1
glibc/lib/libuuid.so.1.3.0
glibc/include/uuid/uuid.h
"
