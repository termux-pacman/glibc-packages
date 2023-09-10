TERMUX_PKG_HOMEPAGE=https://github.com/besser82/libxcrypt
TERMUX_PKG_DESCRIPTION="Modern library for one-way hashing of passwords"
TERMUX_PKG_LICENSE="LGPL-3.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=4.4.36
TERMUX_PKG_SRCURL=https://github.com/besser82/libxcrypt/releases/download/v${TERMUX_PKG_VERSION}/libxcrypt-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=e5e1f4caee0a01de2aee26e3138807d6d3ca2b8e67287966d1fefd65e1fd8943
TERMUX_PKG_DEPENDS="glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--enable-hashes=strong,glibc
--enable-obsolete-api=no
--disable-failure-tokens
"
