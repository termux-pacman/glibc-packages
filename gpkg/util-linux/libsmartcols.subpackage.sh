TERMUX_SUBPKG_DESCRIPTION="Library for smart adaptive formatting of tabular data"
TERMUX_SUBPKG_DEPENDS="glibc"
TERMUX_SUBPKG_BREAKS="util-linux-glibc (<< 2.38.1-1)"
TERMUX_SUBPKG_REPLACES="util-linux-glibc (<< 2.38.1-1)"
TERMUX_SUBPKG_DEPEND_ON_PARENT="no"
TERMUX_SUBPKG_INCLUDE="
glibc/lib/libsmartcols.so
glibc/lib/libsmartcols.so.1
glibc/lib/libsmartcols.so.1.1.0
glibc/lib/pkgconfig/smartcols.pc
glibc/include/libsmartcols/libsmartcols.h
"
