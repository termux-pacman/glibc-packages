TERMUX_PKG_HOMEPAGE=https://www.freetype.org
TERMUX_PKG_DESCRIPTION="Software font engine capable of producing high-quality output"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=2.13.2
TERMUX_PKG_SRCURL=https://downloads.sourceforge.net/freetype/freetype-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=12991c4e55c506dd7f9b765933e62fd2be2e06d421505d7950a132e4f1bb484d
TERMUX_PKG_DEPENDS="brotli-glibc, libbz2-glibc, libpng-glibc, zlib-glibc"
TERMUX_PKG_PROVIDES="freetype2-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="-Dfreetype2:default_library=shared"

termux_step_configure() {
	termux_step_configure_meson
}
