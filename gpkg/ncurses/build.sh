TERMUX_PKG_HOMEPAGE=https://invisible-island.net/ncurses/ncurses.html
TERMUX_PKG_DESCRIPTION="System V Release 4.0 curses emulation library"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
_PKG_VERSION=6.4
_DATE_VERSION=20230520
TERMUX_PKG_VERSION=${_PKG_VERSION}.${_DATE_VERSION}
TERMUX_PKG_REVISION=2
TERMUX_PKG_SRCURL=https://invisible-mirror.net/archives/ncurses/current/ncurses-${_PKG_VERSION}-${_DATE_VERSION}.tgz
TERMUX_PKG_SHA256=a04f69bde2f1b1325d1fb460db7cea28b6da97786ead8ce645daacfb0bcbc004
TERMUX_PKG_DEPENDS="glibc, gcc-libs-glibc"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-root-access
--disable-root-environ
--disable-setuid-environ
--enable-widec
--enable-pc-files
--mandir=$TERMUX_PREFIX/share/man
--with-cxx-binding
--with-cxx-shared
--with-manpage-format=normal
--with-pkg-config-libdir=$TERMUX_PREFIX/lib/pkgconfig
--with-shared
--with-versioned-syms
--with-xterm-kbs=del
--without-ada
"

termux_step_post_make_install() {
	for lib in ncurses ncurses++ form panel menu; do
		printf "INPUT(-l%sw)\n" "${lib}" > $TERMUX_PREFIX/lib/lib${lib}.so
		ln -sv ${lib}w.pc $TERMUX_PREFIX/lib/pkgconfig/${lib}.pc
	done

	printf 'INPUT(-lncursesw)\n' > $TERMUX_PREFIX/lib/libcursesw.so
	ln -sv libncurses.so $TERMUX_PREFIX/lib/libcurses.so

	for lib in tic tinfo; do
		printf "INPUT(libncursesw.so.%s)\n" "${_PKG_VERSION:0:1}" > $TERMUX_PREFIX/lib/lib${lib}.so
		ln -sv libncursesw.so.${TERMUX_PKG_VERSION:0:1} $TERMUX_PREFIX/lib/lib${lib}.so.${_PKG_VERSION:0:1}
		ln -sv ncursesw.pc $TERMUX_PREFIX/lib/pkgconfig/${lib}.pc
	done
}
