TERMUX_PKG_HOMEPAGE=https://xorg.freedesktop.org/
TERMUX_PKG_DESCRIPTION="X11 toolkit intrinsics library"
# Licenses: MIT, HPND
TERMUX_PKG_LICENSE="custom"
TERMUX_PKG_LICENSE_FILE="COPYING"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.3.1
TERMUX_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXt-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=e0a774b33324f4d4c05b199ea45050f87206586d81655f8bef4dba434d931288
TERMUX_PKG_DEPENDS="libsm-glibc, libx11-glibc"
TERMUX_PKG_BUILD_DEPENDS="xorg-util-macros-glibc"
