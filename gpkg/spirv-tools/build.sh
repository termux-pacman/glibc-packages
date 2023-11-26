TERMUX_PKG_HOMEPAGE=https://github.com/KhronosGroup/SPIRV-Tools
TERMUX_PKG_DESCRIPTION="SPIR-V Tools"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="2023.5"
TERMUX_PKG_SRCURL=https://github.com/KhronosGroup/SPIRV-Tools/archive/refs/tags/v${TERMUX_PKG_VERSION}.rc1.tar.gz
TERMUX_PKG_SHA256=aed90b51ce884ce3ac267acec75e785ee743a1e1fd294c25be33b49c5804d77c
TERMUX_PKG_DEPENDS="gcc-libs-glibc"
TERMUX_PKG_BUILD_DEPENDS="spirv-headers-glibc"
TERMUX_PKG_NO_STATICSPLIT=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DSPIRV-Headers_SOURCE_DIR=$TERMUX_PREFIX
-DSPIRV_WERROR=OFF
"
