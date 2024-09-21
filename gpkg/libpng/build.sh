TERMUX_PKG_HOMEPAGE=http://www.libpng.org/pub/png/libpng.html
TERMUX_PKG_DESCRIPTION="Official PNG reference library"
TERMUX_PKG_LICENSE="Libpng"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.6.44
TERMUX_PKG_SRCURL=https://download.sourceforge.net/libpng/libpng-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=60c4da1d5b7f0aa8d158da48e8f8afa9773c1c8baa5d21974df61f1886b8ce8e
TERMUX_PKG_DEPENDS="zlib-glibc, bash-glibc"

termux_step_post_make_install() {
	(
		cd ${TERMUX_PKG_SRCDIR}/contrib/pngminus
		make PNGLIB_SHARED="-L${TERMUX_PKG_BUILDDIR}/.lib -lpng" CFLAGS="$CFLAGS" LDFLAGS="$LDFLAGS" png2pnm pnm2png
		install -m0755 png2pnm pnm2png "${TERMUX_PREFIX}/bin/"
	)
}
