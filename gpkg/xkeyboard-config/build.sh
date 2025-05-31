TERMUX_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/XKeyboardConfig/
TERMUX_PKG_DESCRIPTION="X keyboard configuration files"
# Licenses: HPND, MIT
TERMUX_PKG_LICENSE="custom"
TERMUX_PKG_LICENSE_FILE="COPYING"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="2.44"
TERMUX_PKG_SRCURL=https://xorg.freedesktop.org/archive/individual/data/xkeyboard-config/xkeyboard-config-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=54d2c33eeebb031d48fa590c543e54c9bcbd0f00386ebc6489b2f47a0da4342a
TERMUX_PKG_BUILD_DEPENDS="xorg-xkbcomp-glibc, libxslt-glibc, python-glibc"
TERMUX_PKG_PLATFORM_INDEPENDENT=true
TERMUX_PKG_SETUP_PYTHON=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Dxkb-base=${TERMUX_PREFIX}/share/X11/xkb
-Dcompat-rules=true
-Dxorg-rules-symlinks=true
"
