TERMUX_PKG_HOMEPAGE=https://www.zlib.net/
TERMUX_PKG_DESCRIPTION="Compression library implementing the deflate compression method found in gzip and PKZIP"
TERMUX_PKG_LICENSE="ZLIB"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.3.1
TERMUX_PKG_SRCURL=https://www.zlib.net/zlib-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=38ef96b8dfe510d42707d9c781877914792541133e1870841463bfa73f883e32
TERMUX_PKG_DEPENDS="glibc"

termux_step_configure() {
	"$TERMUX_PKG_SRCDIR/configure" --prefix=$TERMUX_PREFIX
}
