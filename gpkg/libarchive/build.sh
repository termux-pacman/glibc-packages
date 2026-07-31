TERMUX_PKG_HOMEPAGE=https://www.libarchive.org/
TERMUX_PKG_DESCRIPTION="Multi-format archive and compression library"
TERMUX_PKG_LICENSE="BSD 2-Clause"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="3.8.9"
TERMUX_PKG_SRCURL=https://github.com/libarchive/libarchive/releases/download/v$TERMUX_PKG_VERSION/libarchive-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=f5a6539059cf5e597dbeda37bfa4874b1e8dea063c8d93bf85a2b44af90a5bd4
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
