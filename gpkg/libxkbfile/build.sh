TERMUX_PKG_HOMEPAGE=https://xorg.freedesktop.org/
TERMUX_PKG_DESCRIPTION="X11 keyboard file manipulation library"
# Licenses: HPND, MIT
TERMUX_PKG_LICENSE="custom"
TERMUX_PKG_LICENSE_FILE="COPYING"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.1.3
TERMUX_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libxkbfile-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=a9b63eea997abb9ee6a8b4fbb515831c841f471af845a09de443b28003874bec
TERMUX_PKG_DEPENDS="libx11-glibc"
TERMUX_PKG_BUILD_DEPENDS="xorg-util-macros-glibc"
