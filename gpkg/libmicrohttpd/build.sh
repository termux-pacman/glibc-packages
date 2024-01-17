TERMUX_PKG_HOMEPAGE=http://www.gnu.org/software/libmicrohttpd/
TERMUX_PKG_DESCRIPTION="A small C library that is supposed to make it easy to run an HTTP server as part of another application"
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=0.9.77
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://ftp.gnu.org/gnu/libmicrohttpd/libmicrohttpd-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=9e7023a151120060d2806a6ea4c13ca9933ece4eacfc5c9464d20edddb76b0a0
TERMUX_PKG_DEPENDS="libgnutls-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-dependency-tracking
--disable-examples
--enable-curl
--enable-https
--enable-largefile
--enable-messages
--with-pic
"

termux_step_pre_configure() {
	LDFLAGS+=" -lbrotlicommon"
}
