TERMUX_PKG_HOMEPAGE=https://github.com/dex4er/fakechroot/wiki
TERMUX_PKG_DESCRIPTION="Gives a fake chroot environment"
TERMUX_PKG_LICENSE="LGPL-3.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
_VERSION=2.20.1
TERMUX_PKG_VERSION=2.20.2
TERMUX_PKG_SRCURL=https://github.com/dex4er/fakechroot/archive/${_VERSION}.tar.gz
TERMUX_PKG_SHA256=7f9d60d0d48611969e195fadf84d05f6c74f71bbf8f41950ad8f5bf061773e18
TERMUX_PKG_DEPENDS="bash-glibc, perl-glibc, which-glibc"
TERMUX_PKG_RECOMMENDS="fakeroot-glibc, fakehardlink-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--libdir=$TERMUX_PREFIX/lib/libfakeroot"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure() {
	./autogen.sh
}

termux_step_post_make_install() {
	ln -sf libfakeroot/fakechroot/libfakechroot.so $TERMUX_PREFIX/lib
}
