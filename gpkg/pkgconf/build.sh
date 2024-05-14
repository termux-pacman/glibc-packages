TERMUX_PKG_HOMEPAGE=https://gitea.treehouse.systems/ariadne/pkgconf
TERMUX_PKG_DESCRIPTION="Package compiler and linker metadata toolkit"
TERMUX_PKG_LICENSE="ISC"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=2.1.1
TERMUX_PKG_SRCURL=https://gitea.treehouse.systems/ariadne/pkgconf/archive/pkgconf-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=26f56435753a8ee04d6ae2e37a4ea7ae3639478a086e4a451dc69f0c2e4347d7
TERMUX_PKG_DEPENDS="glibc, bash-glibc"

termux_step_post_make_install() {
	ln -sf pkgconf $TERMUX_PREFIX/bin/pkg-config
}
