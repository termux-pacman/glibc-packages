TERMUX_PKG_HOMEPAGE=https://www.mesa3d.org
TERMUX_PKG_DESCRIPTION="OpenGL demonstration and test programs"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=9.0.0
TERMUX_PKG_SRCURL=https://mesa.freedesktop.org/archive/demos/mesa-demos-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=3046a3d26a7b051af7ebdd257a5f23bfeb160cad6ed952329cdff1e9f1ed496b
TERMUX_PKG_DEPENDS="opengl-glibc, glu-glibc, freeglut-glibc"
TERMUX_PKG_BUILD_DEPENDS="glslang-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Dwith-system-data-files=true
"

termux_step_install_license() {
	install -Dm600 -t $TERMUX_PREFIX/share/doc/$TERMUX_PKG_NAME \
		$TERMUX_PKG_BUILDER_DIR/LICENSE
}
