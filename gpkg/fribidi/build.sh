TERMUX_PKG_HOMEPAGE=https://github.com/fribidi/fribidi/
TERMUX_PKG_DESCRIPTION="Implementation of the Unicode Bidirectional Algorithm"
TERMUX_PKG_LICENSE="LGPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="1.0.16"
TERMUX_PKG_SRCURL=https://github.com/fribidi/fribidi/releases/download/v$TERMUX_PKG_VERSION/fribidi-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=1b1cde5b235d40479e91be2f0e88a309e3214c8ab470ec8a2744d82a5a9ea05c
TERMUX_PKG_DEPENDS="glibc"

termux_step_configure() {
	termux_step_configure_meson
}
