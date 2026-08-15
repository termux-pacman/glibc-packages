TERMUX_PKG_HOMEPAGE=https://htop.dev/
TERMUX_PKG_DESCRIPTION="Interactive, text-mode process viewer"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=3.3.0
TERMUX_PKG_SRCURL=https://github.com/htop-dev/htop/archive/refs/tags/${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=1e5cc328eee2bd1acff89f860e3179ea24b85df3ac483433f92a29977b14b045
TERMUX_PKG_DEPENDS="glibc, ncurses-glibc"

termux_step_pre_configure() {
	autoreconf -fiv
}

termux_step_post_make_install() {
	install -Dm644 htop.1 $TERMUX_PREFIX/share/man/man1/htop.1
}
