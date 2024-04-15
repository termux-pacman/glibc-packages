TERMUX_PKG_HOMEPAGE=https://gi.readthedocs.io/
TERMUX_PKG_DESCRIPTION="Uniform machine readable API"
TERMUX_PKG_LICENSE="LGPL-2.0, GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="1.80.1"
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://download.gnome.org/sources/gobject-introspection/${TERMUX_PKG_VERSION%.*}/gobject-introspection-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=a1df7c424e15bda1ab639c00e9051b9adf5cea1a9e512f8a603b53cd199bc6d8
TERMUX_PKG_DEPENDS="libgirepository-glibc, python-glibc"
TERMUX_PKG_BUILD_DEPENDS="coreutils-glibc"
TERMUX_PKG_MESON_NATIVE=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Dpython=$TERMUX_PREFIX/bin/python3
"

termux_step_pre_configure() {
	CPPFLAGS+="-I$TERMUX_PREFIX/include/python${TERMUX_PYTHON_VERSION} -I$TERMUX_PREFIX/include/python${TERMUX_PYTHON_VERSION}/cpython"
}

termux_step_post_make_install() {
	$TERMUX_PREFIX/bin/python3 -m compileall -d $TERMUX_PREFIX/lib/gobject-introspection $TERMUX_PREFIX/lib/gobject-introspection
	$TERMUX_PREFIX/bin/python3 -O -m compileall -d $TERMUX_PREFIX/lib/gobject-introspection $TERMUX_PREFIX/lib/gobject-introspection
}
