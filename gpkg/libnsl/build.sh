TERMUX_PKG_HOMEPAGE=https://github.com/thkukuk/libnsl
TERMUX_PKG_DESCRIPTION="Public client interface library for NIS(YP)"
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=2.0.0
TERMUX_PKG_SRCURL=https://github.com/thkukuk/libnsl/archive/v${TERMUX_PKG_VERSION}/libnsl-v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=eb37be57c1cf650b3a8a4fc7cd66c8b3dfc06215b41956a16325a9388171bc40
TERMUX_PKG_DEPENDS="libtirpc-glibc"

termux_step_pre_configure() {
	autoreconf -fiv
}
