TERMUX_PKG_HOMEPAGE=http://www.bzip.org/
TERMUX_PKG_DESCRIPTION="BZ2 format compression library"
TERMUX_PKG_LICENSE="BSD"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.0.8
TERMUX_PKG_REVISION=3
TERMUX_PKG_SRCURL=https://fossies.org/linux/misc/bzip2-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=47fd74b2ff83effad0ddf62074e6fad1f6b4a77a96e121ab421c20a216371a1f
TERMUX_PKG_DEPENDS="glibc, bash-glibc"
TERMUX_PKG_ESSENTIAL=true
TERMUX_PKG_EXTRA_MAKE_ARGS="PREFIX=$TERMUX_PREFIX"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_configure() {
	# bzip2 does not use configure. But place man pages at correct path:
	sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" $TERMUX_PKG_SRCDIR/Makefile
}

termux_step_make() {
	# bzip2 uses a separate makefile for the shared library
	make -f Makefile-libbz2_so
	make bzip2 bzip2recover
}

termux_step_make_install() {
	install -dm755 $TERMUX_PREFIX/share/man/man1

	install -m755 bzip2-shared $TERMUX_PREFIX/bin/bzip2
	install -m755 bzip2recover bzdiff bzgrep bzmore $TERMUX_PREFIX/bin
	ln -sf bzip2 $TERMUX_PREFIX/bin/bunzip2
	ln -sf bzip2 $TERMUX_PREFIX/bin/bzcat

	cp -a libbz2.so* $TERMUX_PREFIX/lib
	ln -sf libbz2.so.$TERMUX_PKG_VERSION $TERMUX_PREFIX/lib/libbz2.so
	ln -sf libbz2.so.$TERMUX_PKG_VERSION $TERMUX_PREFIX/lib/libbz2.so.1 # For compatibility with some other distros

	install -m644 bzlib.h $TERMUX_PREFIX/include/

	install -m644 bzip2.1 $TERMUX_PREFIX/share/man/man1/
	ln -sf bzip2.1 $TERMUX_PREFIX/share/man/man1/bunzip2.1
	ln -sf bzip2.1 $TERMUX_PREFIX/share/man/man1/bzcat.1
	ln -sf bzip2.1 $TERMUX_PREFIX/share/man/man1/bzip2recover.1

	sed -e "s|@TERMUX_PREFIX@|$TERMUX_PREFIX|g" \
		${TERMUX_PKG_BUILDER_DIR}/bzip2.pc > $TERMUX_PREFIX/lib/pkgconfig/bzip2.pc
}
