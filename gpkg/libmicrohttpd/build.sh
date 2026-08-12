TERMUX_PKG_HOMEPAGE=http://www.gnu.org/software/libmicrohttpd/
TERMUX_PKG_DESCRIPTION="A small C library that is supposed to make it easy to run an HTTP server as part of another application"
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.0.10
TERMUX_PKG_SRCURL=https://ftp.gnu.org/gnu/libmicrohttpd/libmicrohttpd-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=04bfe8ef75db7d629a33de767599765cecadc56274a39822d5d081030d577685
TERMUX_PKG_DEPENDS="libgnutls-glibc, libgmp-glibc-static, libidn2-glibc-static, libunistring-glibc-static"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-dependency-tracking
--disable-examples
--enable-curl
--enable-https
--enable-largefile
--enable-messages
--with-pic
"
