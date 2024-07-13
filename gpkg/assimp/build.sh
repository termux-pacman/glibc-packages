TERMUX_PKG_HOMEPAGE=https://assimp.sourceforge.net/index.html
TERMUX_PKG_DESCRIPTION="Library to import various well-known 3D model formats in an uniform manner"
TERMUX_PKG_LICENSE="BSD"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="5.4.2"
TERMUX_PKG_SRCURL=https://github.com/assimp/assimp/archive/v$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=7414861a7b038e407b510e8b8c9e58d5bf8ca76c9dfe07a01d20af388ec5086a
TERMUX_PKG_DEPENDS="gcc-libs-glibc, zlib-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DASSIMP_BUILD_SAMPLES=OFF
-DASSIMP_WARNINGS_AS_ERRORS=OFF
"
