TERMUX_PKG_HOMEPAGE=https://xorg.freedesktop.org/
TERMUX_PKG_DESCRIPTION="A library that exposes a event API on top of Linux futexes"
TERMUX_PKG_LICENSE="custom"
TERMUX_PKG_LICENSE_FILE="COPYING"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.3.3
TERMUX_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libxshmfence-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=d4a4df096aba96fea02c029ee3a44e11a47eb7f7213c1a729be83e85ec3fde10
TERMUX_PKG_DEPENDS="glibc"
TERMUX_PKG_BUILD_DEPENDS="xorgproto-glibc, xorg-util-macros-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--with-shared-memory-dir=$TERMUX_PREFIX_CLASSICAL/tmp"
