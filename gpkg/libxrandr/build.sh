TERMUX_PKG_HOMEPAGE=https://xorg.freedesktop.org/
TERMUX_PKG_DESCRIPTION="X11 RandR extension library"
# License: HPND
TERMUX_PKG_LICENSE="custom"
TERMUX_PKG_LICENSE_FILE="COPYING"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="1.5.4"
TERMUX_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXrandr-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=1ad5b065375f4a85915aa60611cc6407c060492a214d7f9daf214be752c3b4d3
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="libx11-glibc, libxext-glibc, libxrender-glibc"
TERMUX_PKG_BUILD_DEPENDS="xorgproto-glibc, xorg-util-macros-glibc"
