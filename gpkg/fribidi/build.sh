TERMUX_PKG_HOMEPAGE=https://github.com/fribidi/fribidi/
TERMUX_PKG_DESCRIPTION="Implementation of the Unicode Bidirectional Algorithm"
TERMUX_PKG_LICENSE="LGPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="1.0.13"
TERMUX_PKG_SRCURL=https://github.com/fribidi/fribidi/releases/download/v$TERMUX_PKG_VERSION/fribidi-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=7fa16c80c81bd622f7b198d31356da139cc318a63fc7761217af4130903f54a2
TERMUX_PKG_DEPENDS="glibc"

termux_step_configure() {
	termux_step_configure_meson
}
