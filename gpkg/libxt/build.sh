TERMUX_PKG_HOMEPAGE=https://xorg.freedesktop.org/
TERMUX_PKG_DESCRIPTION="X11 toolkit intrinsics library"
# Licenses: MIT, HPND
TERMUX_PKG_LICENSE="custom"
TERMUX_PKG_LICENSE_FILE="COPYING"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.3.0
TERMUX_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXt-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=52820b3cdb827d08dc90bdfd1b0022a3ad8919b57a39808b12591973b331bf91
TERMUX_PKG_DEPENDS="libsm-glibc, libx11-glibc"
TERMUX_PKG_BUILD_DEPENDS="xorg-util-macros-glibc"
