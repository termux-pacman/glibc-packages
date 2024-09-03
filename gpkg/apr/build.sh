TERMUX_PKG_HOMEPAGE=https://apr.apache.org/
TERMUX_PKG_DESCRIPTION="Apache Portable Runtime Library"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.7.5
TERMUX_PKG_SRCURL=https://dlcdn.apache.org/apr/apr-${TERMUX_PKG_VERSION}.tar.bz2
TERMUX_PKG_SHA256=cd0f5d52b9ab1704c72160c5ee3ed5d3d4ca2df4a7f8ab564e3cb352b67232f2
TERMUX_PKG_DEPENDS="libuuid-glibc, bash-glibc"
TERMUX_PKG_BUILD_DEPENDS="libxcrypt-glibc"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--includedir=$TERMUX_PREFIX/include/apr-1
--with-installbuilddir=$TERMUX_PREFIX/share/apr-1/build
--enable-nonportable-atomics
--with-devrandom=/dev/urandom
--disable-static
"

termux_step_post_configure() {
	# Avoid overlinking
	sed -i 's/ -shared / -Wl,--as-needed\0/g' ./libtool
}
