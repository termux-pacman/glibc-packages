TERMUX_PKG_HOMEPAGE=https://xorg.freedesktop.org/
TERMUX_PKG_DESCRIPTION="X11 Screen Saver extension library"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="1.2.4"
TERMUX_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXScrnSaver-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=75cd2859f38e207a090cac980d76bc71e9da99d48d09703584e00585abc920fe
TERMUX_PKG_DEPENDS="libx11-glibc, libxext-glibc, glibc"
TERMUX_PKG_BUILD_DEPENDS="xorgproto-glibc, xorg-util-macros-glibc"
