TERMUX_PKG_HOMEPAGE=https://www.gnu.org/software/libiconv/
TERMUX_PKG_DESCRIPTION="An implementation of iconv()"
TERMUX_PKG_LICENSE="LGPL-2.1, GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.18
TERMUX_PKG_SRCURL=https://ftp.gnu.org/pub/gnu/libiconv/libiconv-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=3b08f5f4f9b4eb82f151a7040bfd6fe6c6fb922efe4b1659c66ea933276965e8
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
