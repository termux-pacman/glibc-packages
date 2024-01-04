TERMUX_PKG_HOMEPAGE=https://www.gnu.org/software/libiconv/
TERMUX_PKG_DESCRIPTION="An implementation of iconv()"
TERMUX_PKG_LICENSE="LGPL-2.1, GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.17
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://ftp.gnu.org/pub/gnu/libiconv/libiconv-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=8f74213b56238c85a50a5329f77e06198771e70dd9a739779f4c02f65d971313
TERMUX_PKG_DEPENDS="glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--enable-extra-encodings
--bindir=$TERMUX_PREFIX/bin/libiconv-d
--includedir=$TERMUX_PREFIX/include/libiconv-d
"

termux_step_post_make_install() {
	mv $TERMUX_PREFIX/bin/libiconv-d/{iconv,libiconv}
	mv $TERMUX_PREFIX/bin/libiconv-d/libiconv $TERMUX_PREFIX/bin
	rm -fr $TERMUX_PREFIX/bin/libiconv-d

	mv $TERMUX_PREFIX/include/libiconv-d/{iconv.h,libiconv.h}
	mv $TERMUX_PREFIX/include/libiconv-d/* $TERMUX_PREFIX/include
	rm -fr $TERMUX_PREFIX/include/libiconv-d
}
