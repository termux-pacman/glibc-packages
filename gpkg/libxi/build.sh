TERMUX_PKG_HOMEPAGE=https://xorg.freedesktop.org/
TERMUX_PKG_DESCRIPTION="X11 Input extension library"
# Licenses: MIT, HPND
TERMUX_PKG_LICENSE="custom"
TERMUX_PKG_LICENSE_FILE="COPYING"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.8.2
TERMUX_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXi-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=d0e0555e53d6e2114eabfa44226ba162d2708501a25e18d99cfb35c094c6c104
TERMUX_PKG_DEPENDS="libxext-glibc, libxfixes-glibc"
TERMUX_PKG_BUILD_DEPENDS="xorgproto-glibc, xorg-util-macros-glibc"
