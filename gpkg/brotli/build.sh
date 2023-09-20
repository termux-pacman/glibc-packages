TERMUX_PKG_HOMEPAGE=https://github.com/google/brotli
TERMUX_PKG_DESCRIPTION="lossless compression algorithm and format (command line utility)"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.1.0
TERMUX_PKG_SRCURL=https://github.com/google/brotli/archive/v$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=e720a6ca29428b803f4ad165371771f5398faba397edf6778837a18599ea13ff
TERMUX_PKG_DEPENDS="glibc, gcc-libs-glibc"
TERMUX_PKG_FORCE_CMAKE=true

termux_step_post_make_install() {
	mkdir -p $TERMUX_PREFIX/share/man/man{1,3}
	cp $TERMUX_PKG_SRCDIR/docs/brotli.1 $TERMUX_PREFIX/share/man/man1/
	cp $TERMUX_PKG_SRCDIR/docs/*.3 $TERMUX_PREFIX/share/man/man3/
}
