TERMUX_PKG_HOMEPAGE=https://xorg.freedesktop.org/
TERMUX_PKG_DESCRIPTION="X11 client-side library"
TERMUX_PKG_LICENSE="MIT, X11"
TERMUX_PKG_LICENSE_FILE="COPYING"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="1.8.12"
TERMUX_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libX11-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=fa026f9bb0124f4d6c808f9aef4057aad65e7b35d8ff43951cef0abe06bb9a9a
TERMUX_PKG_DEPENDS="libxcb-glibc, xorgproto-glibc"
TERMUX_PKG_BUILD_DEPENDS="xorg-util-macros-glibc, xtrans-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-xf86bigfont
"
