TERMUX_PKG_HOMEPAGE=https://www.zlib.net/
TERMUX_PKG_DESCRIPTION="Compression library implementing the deflate compression method found in gzip and PKZIP"
TERMUX_PKG_LICENSE="ZLIB"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.3.1
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://www.zlib.net/zlib-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=38ef96b8dfe510d42707d9c781877914792541133e1870841463bfa73f883e32
TERMUX_PKG_DEPENDS="glibc"
TERMUX_PKG_BUILD32=true

termux_step_configure() {
	"$TERMUX_PKG_SRCDIR/configure" --prefix="${TERMUX_PREFIX}" --libdir="${TERMUX__PREFIX__LIB_DIR}" --includedir="${TERMUX__PREFIX__INCLUDE_DIR}"
}

termux_step_make_install32() {
	local zlib32_dir="${TERMUX_PKG_TMPDIR}/zlib32/"
	mkdir -p ${zlib32_dir}
	make DESTDIR=${zlib32_dir} install

	cp -TR ${zlib32_dir}/${TERMUX__PREFIX__LIB_DIR} $TERMUX__PREFIX__LIB_DIR
	cp -TR ${zlib32_dir}/${TERMUX__PREFIX__INCLUDE_DIR} $TERMUX__PREFIX__INCLUDE_DIR
}
