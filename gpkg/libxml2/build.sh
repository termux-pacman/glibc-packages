TERMUX_PKG_HOMEPAGE=http://www.xmlsoft.org
TERMUX_PKG_DESCRIPTION="Library for parsing XML documents"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
_MAJOR_VERSION=2.11
TERMUX_PKG_VERSION=${_MAJOR_VERSION}.5
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://download.gnome.org/sources/libxml2/${_MAJOR_VERSION}/libxml2-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=3727b078c360ec69fa869de14bd6f75d7ee8d36987b071e6928d4720a28df3a6
TERMUX_PKG_SETUP_PYTHON=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--with-python
--with-history
--with-icu
--with-threads
"
TERMUX_PKG_DEPENDS="libicu-glibc, ncurses-glibc, readline-glibc, zlib-glibc, liblzma-glibc"
