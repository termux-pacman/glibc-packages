TERMUX_PKG_HOMEPAGE=https://infozip.sourceforge.net/Zip.html
TERMUX_PKG_DESCRIPTION="File compression and packaging utility compatible with PKZIP"
TERMUX_PKG_LICENSE="BSD"
TERMUX_PKG_LICENSE_FILE="LICENSE"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=3.0
TERMUX_PKG_REVISION=2
TERMUX_PKG_SRCURL=https://downloads.sourceforge.net/project/infozip/Zip%203.x%20%28latest%29/${TERMUX_PKG_VERSION}/zip30.tar.gz
TERMUX_PKG_SHA256=f0e8bb1f9b7eb0b01285495a2699df3a4b766784c1765a8f1aeedf63c0806369
TERMUX_PKG_DEPENDS="glibc, libbz2-glibc"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_configure() {
	# Zip does not use a configure script.
	# The Makefile uses CC/CFLAGS from environment.
	true
}

termux_step_make() {
	CPP="$CC -E" \
	make -f unix/Makefile \
		generic \
		CFLAGS="-I. -DUNIX $CFLAGS $CPPFLAGS"
}

termux_step_make_install() {
	install -dm755 $TERMUX_PREFIX/bin
	install -dm755 $TERMUX_PREFIX/share/man/man1

	install -m755 zip zipcloak zipnote zipsplit $TERMUX_PREFIX/bin/

	install -m644 man/zip.1 $TERMUX_PREFIX/share/man/man1/zip.1
	install -m644 man/zipcloak.1 $TERMUX_PREFIX/share/man/man1/zipcloak.1
	install -m644 man/zipnote.1 $TERMUX_PREFIX/share/man/man1/zipnote.1
	install -m644 man/zipsplit.1 $TERMUX_PREFIX/share/man/man1/zipsplit.1
}
