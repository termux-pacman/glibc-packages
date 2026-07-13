TERMUX_PKG_HOMEPAGE=https://www.zlib.net/
TERMUX_PKG_DESCRIPTION="Compression library implementing the deflate compression method found in gzip and PKZIP"
TERMUX_PKG_LICENSE="ZLIB"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.3.2
TERMUX_PKG_SRCURL=https://www.zlib.net/zlib-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=d7a0654783a4da529d1bb793b7ad9c3318020af77667bcae35f95d0e42a792f3
TERMUX_PKG_DEPENDS="glibc"

termux_step_configure() {
	"$TERMUX_PKG_SRCDIR/configure" --prefix=$TERMUX_PREFIX
}
