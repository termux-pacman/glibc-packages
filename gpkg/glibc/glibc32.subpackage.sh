TERMUX_SUBPKG_DESCRIPTION="GNU C Library (32-bit)"
TERMUX_SUBPKG_DEPENDS="linux-api-headers-glibc"
TERMUX_SUBPKG_EXCLUDED_ARCHES="arm, i686"
TERMUX_SUBPKG_INCLUDE="
glibc/lib32/
glibc/lib/ld-linux-armhf.so.3
glibc/lib/ld-linux.so.2"
