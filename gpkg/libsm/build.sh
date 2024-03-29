TERMUX_PKG_HOMEPAGE=https://xorg.freedesktop.org/
TERMUX_PKG_DESCRIPTION="X11 Session Management library"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.2.4
TERMUX_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libSM-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=fdcbe51e4d1276b1183da77a8a4e74a137ca203e0bcfb20972dd5f3347e97b84
TERMUX_PKG_DEPENDS="libice-glibc, libuuid-glibc"
TERMUX_PKG_BUILD_DEPENDS="xorg-util-macros-glibc, xtrans-glibc, xorgproto-glibc"
