TERMUX_PKG_HOMEPAGE=https://assimp.sourceforge.net/index.html
TERMUX_PKG_DESCRIPTION="Library to import various well-known 3D model formats in an uniform manner"
TERMUX_PKG_LICENSE="BSD"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="5.3.1"
TERMUX_PKG_SRCURL=https://github.com/assimp/assimp/archive/v$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=a07666be71afe1ad4bc008c2336b7c688aca391271188eb9108d0c6db1be53f1
TERMUX_PKG_DEPENDS="gcc-libs-glibc, zlib-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DASSIMP_BUILD_SAMPLES=OFF
-DASSIMP_WARNINGS_AS_ERRORS=OFF
"
