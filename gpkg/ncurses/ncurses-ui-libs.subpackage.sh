TERMUX_SUBPKG_INCLUDE="
glibc/lib/libform*.so*
glibc/lib/libmenu*.so*
glibc/lib/libpanel*.so*
glibc/lib/pkgconfig/form*.pc
glibc/lib/pkgconfig/menu*.pc
glibc/lib/pkgconfig/panel*.pc
"
TERMUX_SUBPKG_DESCRIPTION="Libraries for terminal user interfaces based on ncurses"
TERMUX_SUBPKG_BREAKS="ncurses (<< 6.4)"
TERMUX_SUBPKG_REPLACES="ncurses (<< 6.4)"
