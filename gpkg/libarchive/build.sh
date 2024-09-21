TERMUX_PKG_HOMEPAGE=https://www.libarchive.org/
TERMUX_PKG_DESCRIPTION="Multi-format archive and compression library"
TERMUX_PKG_LICENSE="BSD 2-Clause"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="3.7.5"
TERMUX_PKG_SRCURL=https://github.com/libarchive/libarchive/releases/download/v$TERMUX_PKG_VERSION/libarchive-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=37556113fe44d77a7988f1ef88bf86ab68f53d11e85066ffd3c70157cc5110f1
TERMUX_PKG_DEPENDS="libacl-glibc, libbz2-glibc, libexpat-glibc, liblz4-glibc, openssl-glibc, liblzma-glibc, zlib-glibc, zstd-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--without-xml2
--without-nettle
--disable-static
"

termux_step_post_make_install() {
	# https://github.com/libarchive/libarchive/issues/1766
	sed -i '/^Requires\.private:/s/ iconv//' \
		$TERMUX_PREFIX/lib/pkgconfig/libarchive.pc
}
