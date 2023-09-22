TERMUX_PKG_HOMEPAGE=https://gitea.treehouse.systems/ariadne/pkgconf
TERMUX_PKG_DESCRIPTION="Package compiler and linker metadata toolkit"
TERMUX_PKG_LICENSE="ISC"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=2.0.3
TERMUX_PKG_SRCURL=https://gitea.treehouse.systems/ariadne/pkgconf/archive/pkgconf-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=be4c3543ed5dda81d2f3da09ecfaaa661641e76e41831d4271e893924d8af461
TERMUX_PKG_DEPENDS="glibc, bash-glibc"

termux_step_post_make_install() {
	ln -sf pkgconf $TERMUX_PREFIX/bin/pkg-config
}
