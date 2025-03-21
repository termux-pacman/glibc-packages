TERMUX_PKG_HOMEPAGE=https://xorg.freedesktop.org/
TERMUX_PKG_DESCRIPTION="X cursor management library"
# License: HPND
TERMUX_PKG_LICENSE="custom"
TERMUX_PKG_LICENSE_FILE="COPYING"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.2.3
TERMUX_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXcursor-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=fde9402dd4cfe79da71e2d96bb980afc5e6ff4f8a7d74c159e1966afb2b2c2c0
TERMUX_PKG_DEPENDS="libxfixes-glibc, libxrender-glibc"
TERMUX_PKG_BUILD_DEPENDS="xorg-util-macros-glibc"
