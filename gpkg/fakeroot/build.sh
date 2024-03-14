TERMUX_PKG_HOMEPAGE=https://tracker.debian.org/pkg/fakeroot
TERMUX_PKG_DESCRIPTION="Tool for simulating superuser privileges"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.34
TERMUX_PKG_SRCURL=https://deb.debian.org/debian/pool/main/f/fakeroot/fakeroot_${TERMUX_PKG_VERSION}.orig.tar.gz
TERMUX_PKG_SHA256=5727f16d8903792588efa7a9f8ef8ce71f8756e746b62e45162e7735662e56bb
TERMUX_PKG_DEPENDS="sed-glibc, util-linux-glibc, bash-glibc, libcap-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--libdir=$TERMUX_PREFIX/lib/libfakeroot
--disable-static
--with-ipc=tcp
"

termux_step_post_make_install() {
	ln -sf libfakeroot/libfakeroot.so $TERMUX_PREFIX/lib
}
