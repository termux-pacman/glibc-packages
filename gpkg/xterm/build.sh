TERMUX_PKG_HOMEPAGE=https://invisible-island.net/xterm/
TERMUX_PKG_DESCRIPTION="X terminal emulator for the X Window System"
TERMUX_PKG_LICENSE="custom"
TERMUX_PKG_LICENSE_FILE="COPYING"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=390
TERMUX_PKG_SRCURL=https://invisible-mirror.net/archives/xterm/xterm-${TERMUX_PKG_VERSION}.tgz
TERMUX_PKG_SHA256=75117c3cc5174a09c425ef106e69404d72f5ef05e03a5da00aaf15792d6f9c0f
TERMUX_PKG_DEPENDS="libx11-glibc, libxft-glibc, libxt-glibc, libxaw-glibc, ncurses-glibc"
TERMUX_PKG_BUILD_DEPENDS="xorg-util-macros-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--enable-wide-chars
--enable-256-color
--enable-true-color
--with-x
--with-xft
--with-pcre2=no
--with-tty-group=tty
"
