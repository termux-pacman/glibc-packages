TERMUX_PKG_HOMEPAGE=https://tracker.debian.org/pkg/fakeroot
TERMUX_PKG_DESCRIPTION="Tool for simulating superuser privileges"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.35
TERMUX_PKG_SRCURL=https://deb.debian.org/debian/pool/main/f/fakeroot/fakeroot_${TERMUX_PKG_VERSION}.orig.tar.gz
TERMUX_PKG_SHA256=e5a427b4ab1eb4a2158b3312547a4155aede58735cd5c2910421988834b440a4
TERMUX_PKG_DEPENDS="sed-glibc, util-linux-glibc, bash-glibc, libcap-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--libdir=$TERMUX_PREFIX/lib/libfakeroot
--disable-static
--with-ipc=tcp
"

termux_step_post_make_install() {
	ln -sf libfakeroot/libfakeroot.so $TERMUX_PREFIX/lib
}
