TERMUX_PKG_HOMEPAGE=http://www.libpng.org/pub/png/libpng.html
TERMUX_PKG_DESCRIPTION="Official PNG reference library"
TERMUX_PKG_LICENSE="Libpng"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.6.58
TERMUX_PKG_SRCURL=https://download.sourceforge.net/libpng/libpng-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=28eb403f51f0f7405249132cecfe82ea5c0ef97f1b32c5a65828814ae0d34775
TERMUX_PKG_DEPENDS="zlib-glibc, bash-glibc"

termux_step_post_make_install() {
	(
		cd ${TERMUX_PKG_SRCDIR}/contrib/pngminus
		make PNGLIB_SHARED="-L${TERMUX_PKG_BUILDDIR}/.lib -lpng" CFLAGS="$CFLAGS" LDFLAGS="$LDFLAGS" png2pnm pnm2png
		install -m0755 png2pnm pnm2png "${TERMUX_PREFIX}/bin/"
	)
}
