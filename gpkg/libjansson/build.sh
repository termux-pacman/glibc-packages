TERMUX_PKG_HOMEPAGE=http://www.digip.org/jansson/
TERMUX_PKG_DESCRIPTION="C library for encoding, decoding and manipulating JSON data"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=2.15.1
TERMUX_PKG_SRCURL=https://github.com/akheron/jansson/archive/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=dbf95cb0af903f4fb8b61507d96b45b67db7d1479688ede352e1d571394d06f7
TERMUX_PKG_DEPENDS="glibc"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure() {
	autoreconf -fi
}
