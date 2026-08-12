TERMUX_PKG_HOMEPAGE=https://www.freetype.org
TERMUX_PKG_DESCRIPTION="Software font engine capable of producing high-quality output"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=2.14.3
TERMUX_PKG_SRCURL=https://downloads.sourceforge.net/freetype/freetype-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=36bc4f1cc413335368ee656c42afca65c5a3987e8768cc28cf11ba775e785a5f
TERMUX_PKG_DEPENDS="brotli-glibc, libbz2-glibc, libpng-glibc, zlib-glibc"
TERMUX_PKG_PROVIDES="freetype2-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Ddefault_library=shared
-Dharfbuzz=disabled
"

termux_step_configure() {
	termux_step_configure_meson
}
