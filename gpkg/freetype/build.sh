TERMUX_PKG_HOMEPAGE=https://www.freetype.org
TERMUX_PKG_DESCRIPTION="Software font engine capable of producing high-quality output"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=2.13.3
TERMUX_PKG_SRCURL=https://downloads.sourceforge.net/freetype/freetype-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=0550350666d427c74daeb85d5ac7bb353acba5f76956395995311a9c6f063289
TERMUX_PKG_DEPENDS="brotli-glibc, libbz2-glibc, libpng-glibc, zlib-glibc"
TERMUX_PKG_PROVIDES="freetype2-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="-Dfreetype2:default_library=shared"

termux_step_configure() {
	termux_step_configure_meson
}
