TERMUX_PKG_HOMEPAGE=https://invisible-island.net/ncurses/ncurses.html
TERMUX_PKG_DESCRIPTION="System V Release 4.0 curses emulation library"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
_PKG_VERSION=6.6
_DATE_VERSION=20260725
TERMUX_PKG_VERSION=${_PKG_VERSION}.${_DATE_VERSION}
TERMUX_PKG_SRCURL=https://github.com/ThomasDickey/ncurses-snapshots/archive/refs/tags/v${TERMUX_PKG_VERSION//./_}.tar.gz
TERMUX_PKG_SHA256=81dd885260908d8bbf94841f99871dde4cdd7e60f242c504db9e283b788a2677
TERMUX_PKG_DEPENDS="gcc-libs-glibc"
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
		ln -svf ${lib}w.pc $TERMUX_PREFIX/lib/pkgconfig/${lib}.pc
	done

	printf 'INPUT(-lncursesw)\n' > $TERMUX_PREFIX/lib/libcursesw.so
	ln -svf libncurses.so $TERMUX_PREFIX/lib/libcurses.so

	for lib in tic tinfo; do
		printf "INPUT(libncursesw.so.%s)\n" "${_PKG_VERSION:0:1}" > $TERMUX_PREFIX/lib/lib${lib}.so
		ln -svf libncursesw.so.${TERMUX_PKG_VERSION:0:1} $TERMUX_PREFIX/lib/lib${lib}.so.${_PKG_VERSION:0:1}
		ln -svf ncursesw.pc $TERMUX_PREFIX/lib/pkgconfig/${lib}.pc
	done

	mkdir -p $TERMUX_PREFIX/include/ncurses
	for i in $TERMUX_PREFIX/include/ncursesw/*; do
		mv ${i} $TERMUX_PREFIX/include
		ln -svf ../${i##*/} $TERMUX_PREFIX/include/ncurses
		ln -svf ../${i##*/} $TERMUX_PREFIX/include/ncursesw
	done
}
