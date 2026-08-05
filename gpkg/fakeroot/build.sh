TERMUX_PKG_HOMEPAGE=https://tracker.debian.org/pkg/fakeroot
TERMUX_PKG_DESCRIPTION="Tool for simulating superuser privileges"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=2.1.4
TERMUX_PKG_SRCURL=https://deb.debian.org/debian/pool/main/f/fakeroot/fakeroot_${TERMUX_PKG_VERSION}.orig.tar.xz
TERMUX_PKG_SHA256=0822bd5a9f0cf19d2ba0546b88b0432d4d3d9917db62c57b74044ccadba06e49
TERMUX_PKG_DEPENDS="sed-glibc, util-linux-glibc, bash-glibc, libcap-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--libdir=$TERMUX_PREFIX/lib/libfakeroot
--disable-static
--with-ipc=tcp
"

termux_step_pre_configure() {
	autoreconf -fi
}

termux_step_post_make_install() {
	ln -sf libfakeroot/libfakeroot.so $TERMUX_PREFIX/lib
}
