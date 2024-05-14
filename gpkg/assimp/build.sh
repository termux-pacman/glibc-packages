TERMUX_PKG_HOMEPAGE=https://assimp.sourceforge.net/index.html
TERMUX_PKG_DESCRIPTION="Library to import various well-known 3D model formats in an uniform manner"
TERMUX_PKG_LICENSE="BSD"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="5.4.1"
TERMUX_PKG_SRCURL=https://github.com/assimp/assimp/archive/v$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=a1bf71c4eb851ca336bba301730cd072b366403e98e3739d6a024f6313b8f954
TERMUX_PKG_DEPENDS="gcc-libs-glibc, zlib-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DASSIMP_BUILD_SAMPLES=OFF
-DASSIMP_WARNINGS_AS_ERRORS=OFF
"
