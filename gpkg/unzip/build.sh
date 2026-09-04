TERMUX_PKG_HOMEPAGE=https://infozip.sourceforge.net/UnZip.html
TERMUX_PKG_DESCRIPTION="Extraction utility for .zip compressed archives"
TERMUX_PKG_LICENSE="BSD"
TERMUX_PKG_LICENSE_FILE="LICENSE"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=6.0
TERMUX_PKG_REVISION=8
TERMUX_PKG_SRCURL=https://downloads.sourceforge.net/project/infozip/UnZip%206.x%20%28latest%29/${TERMUX_PKG_VERSION}/unzip60.tar.gz
TERMUX_PKG_SHA256=036d96991646d0449ed0aa952e4fbe21b476ce994abc276e49d30e686708bd37
TERMUX_PKG_DEPENDS="glibc, libbz2-glibc"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_configure() {
	# UnZip does not use a configure script.
	true
}

termux_step_make() {
	make -f unix/Makefile \
		generic \
		CFLAGS="-I. -DUNIX $CFLAGS $CPPFLAGS"
}

termux_step_make_install() {
	install -dm755 $TERMUX_PREFIX/bin
	install -dm755 $TERMUX_PREFIX/share/man/man1

	install -m755 unzip funzip unzipsfx $TERMUX_PREFIX/bin/
	install -m755 unix/zipgrep $TERMUX_PREFIX/bin/
	ln -sf unzip $TERMUX_PREFIX/bin/zipinfo

	install -m644 man/funzip.1 $TERMUX_PREFIX/share/man/man1/funzip.1
	install -m644 man/unzip.1 $TERMUX_PREFIX/share/man/man1/unzip.1
	install -m644 man/unzipsfx.1 $TERMUX_PREFIX/share/man/man1/unzipsfx.1
	install -m644 man/zipgrep.1 $TERMUX_PREFIX/share/man/man1/zipgrep.1
	install -m644 man/zipinfo.1 $TERMUX_PREFIX/share/man/man1/zipinfo.1
}
