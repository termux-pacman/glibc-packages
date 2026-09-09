TERMUX_PKG_HOMEPAGE=https://gitea.treehouse.systems/ariadne/pkgconf
TERMUX_PKG_DESCRIPTION="Package compiler and linker metadata toolkit"
TERMUX_PKG_LICENSE="ISC"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=3.0.7
TERMUX_PKG_SRCURL=https://github.com/pkgconf/pkgconf/releases/download/pkgconf-${TERMUX_PKG_VERSION}/pkgconf-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=028889796fd6d556e019d35b8e8d68d321cbb5cf9827d3ea7653625629641345
TERMUX_PKG_DEPENDS="glibc, bash-glibc"

termux_step_post_make_install() {
	ln -sf pkgconf $TERMUX_PREFIX/bin/pkg-config
}
