TERMUX_PKG_HOMEPAGE=http://www.pixman.org/
TERMUX_PKG_DESCRIPTION="Low-level library for pixel manipulation"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=0.43.4
TERMUX_PKG_SRCURL=https://cairographics.org/releases/pixman-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=a0624db90180c7ddb79fc7a9151093dc37c646d8c38d3f232f767cf64b85a226
TERMUX_PKG_DEPENDS="glibc"
TERMUX_PKG_BUILD_DEPENDS="libpng-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Dloongson-mmi=disabled
-Dvmx=disabled
-Darm-simd=disabled
-Dneon=disabled
-Da64-neon=disabled
-Diwmmxt=disabled
-Dmips-dspr2=disabled
-Dgtk=disabled
"

termux_step_configure() {
	termux_step_configure_meson
}
