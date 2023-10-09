TERMUX_PKG_HOMEPAGE=https://invisible-island.net/ncurses/ncurses.html
TERMUX_PKG_DESCRIPTION="System V Release 4.0 curses emulation library"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
_PKG_VERSION=6.4
_DATE_VERSION=20231001
TERMUX_PKG_VERSION=${_PKG_VERSION}.${_DATE_VERSION}
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://invisible-mirror.net/archives/ncurses/current/ncurses-${_PKG_VERSION}-${_DATE_VERSION}.tgz
TERMUX_PKG_SHA256=30b8dbe4800b07be5e852e8cb15fa4ffca30e112fa3a8b0e7c25777937d0ae6c
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
		ln -svf ${lib}w.pc $TERMUX_PREFIX/lib/pkgconfig/${lib}.pc
	done

	printf 'INPUT(-lncursesw)\n' > $TERMUX_PREFIX/lib/libcursesw.so
	ln -svf libncurses.so $TERMUX_PREFIX/lib/libcurses.so

	for lib in tic tinfo; do
		printf "INPUT(libncursesw.so.%s)\n" "${_PKG_VERSION:0:1}" > $TERMUX_PREFIX/lib/lib${lib}.so
		ln -svf libncursesw.so.${TERMUX_PKG_VERSION:0:1} $TERMUX_PREFIX/lib/lib${lib}.so.${_PKG_VERSION:0:1}
		ln -svf ncursesw.pc $TERMUX_PREFIX/lib/pkgconfig/${lib}.pc
	done
}

termux_step_post_massage() {
	cd "$TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/include" || exit 1
	mv ncursesw/* .
	mkdir ncurses
	for _file in *.h; do
		ln -s ../$_file ncurses
		ln -s ../$_file ncursesw
	done
}
