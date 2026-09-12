TERMUX_PKG_HOMEPAGE=https://github.com/besser82/libxcrypt
TERMUX_PKG_DESCRIPTION="Modern library for one-way hashing of passwords"
TERMUX_PKG_LICENSE="LGPL-3.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=4.5.2
TERMUX_PKG_SRCURL=https://github.com/besser82/libxcrypt/releases/download/v${TERMUX_PKG_VERSION}/libxcrypt-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=71513a31c01a428bccd5367a32fd95f115d6dac50fb5b60c779d5c7942aec071
TERMUX_PKG_DEPENDS="glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--enable-hashes=strong,glibc
--enable-obsolete-api=no
--disable-failure-tokens
"

termux_step_pre_configure() {
	CFLAGS+=" -Wno-discarded-qualifiers"
}
