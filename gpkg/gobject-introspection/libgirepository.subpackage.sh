TERMUX_SUBPKG_INCLUDE="
glibc/include/gobject-introspection-1.0
glibc/lib/libgirepository-1.0.so*
glibc/lib/pkgconfig/gobject-introspection*-1.0.pc
glibc/lib/girepository-1.0/GIRepository-2.0.typelib
glibc/share/gir-1.0/GIRepository-2.0.gir
glibc/share/gtk-doc
"
TERMUX_SUBPKG_DESCRIPTION="Introspection system for GObject-based libraries"
TERMUX_SUBPKG_DEPEND_ON_PARENT="no"
TERMUX_SUBPKG_DEPENDS="libffi-glibc, glib-glibc"
