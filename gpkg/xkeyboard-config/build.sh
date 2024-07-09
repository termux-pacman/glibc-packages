TERMUX_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/XKeyboardConfig/
TERMUX_PKG_DESCRIPTION="X keyboard configuration files"
# Licenses: HPND, MIT
TERMUX_PKG_LICENSE="custom"
TERMUX_PKG_LICENSE_FILE="COPYING"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="2.42"
TERMUX_PKG_SRCURL=https://xorg.freedesktop.org/archive/individual/data/xkeyboard-config/xkeyboard-config-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=a6b06ebfc1f01fc505f2f05f265f95f67cc8873a54dd247e3c2d754b8f7e0807
TERMUX_PKG_BUILD_DEPENDS="xorg-xkbcomp-glibc, libxslt-glibc, python-glibc"
TERMUX_PKG_PLATFORM_INDEPENDENT=true
TERMUX_PKG_SETUP_PYTHON=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Dxkb-base=${TERMUX_PREFIX}/share/X11/xkb
-Dcompat-rules=true
-Dxorg-rules-symlinks=true
"
