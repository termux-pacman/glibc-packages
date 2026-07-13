TERMUX_PKG_HOMEPAGE=http://www.pixman.org/
TERMUX_PKG_DESCRIPTION="Low-level library for pixel manipulation"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=0.46.4
TERMUX_PKG_SRCURL=https://cairographics.org/releases/pixman-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=d09c44ebc3bd5bee7021c79f922fe8fb2fb57f7320f55e97ff9914d2346a591c
TERMUX_PKG_DEPENDS="glibc"
TERMUX_PKG_BUILD_DEPENDS="libpng-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Dloongson-mmi=disabled
-Dvmx=disabled
-Darm-simd=disabled
-Dneon=disabled
-Da64-neon=disabled
-Drvv=disabled
-Dmmx=disabled
-Dsse2=disabled
-Dssse3=disabled
-Dmips-dspr2=disabled
-Dgtk=disabled
"

termux_step_configure() {
	termux_step_configure_meson
}
