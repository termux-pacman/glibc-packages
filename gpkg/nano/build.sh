TERMUX_PKG_HOMEPAGE=https://www.nano-editor.org/
TERMUX_PKG_DESCRIPTION="Small, free and friendly text editor"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=8.3
TERMUX_PKG_SRCURL=https://nano-editor.org/dist/v${TERMUX_PKG_VERSION/.*/}/nano-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=551b717b2e28f7e90f749323686a1b5bbbd84cfa1390604d854a3ca3778f111e
TERMUX_PKG_DEPENDS="ncurses-glibc, file-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--enable-color
--enable-nanorc
--enable-multibuffer
"
TERMUX_PKG_CONFFILES="glibc/etc/nanorc"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_post_make_install() {
	install -DTm644 doc/sample.nanorc $TERMUX_PREFIX/etc/nanorc
	sed -i "$(grep -n '/share/nano/\*.nanorc' doc/sample.nanorc | awk -F ':' '{printf $1}')s/# include/include/" $TERMUX_PREFIX/etc/nanorc
}
