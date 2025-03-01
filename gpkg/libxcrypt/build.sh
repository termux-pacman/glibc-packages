TERMUX_PKG_HOMEPAGE=https://github.com/besser82/libxcrypt
TERMUX_PKG_DESCRIPTION="Modern library for one-way hashing of passwords"
TERMUX_PKG_LICENSE="LGPL-3.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=4.4.38
TERMUX_PKG_SRCURL=https://github.com/besser82/libxcrypt/releases/download/v${TERMUX_PKG_VERSION}/libxcrypt-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=80304b9c306ea799327f01d9a7549bdb28317789182631f1b54f4511b4206dd6
TERMUX_PKG_DEPENDS="glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--enable-hashes=strong,glibc
--enable-obsolete-api=no
--disable-failure-tokens
"
