TERMUX_PKG_HOMEPAGE=http://www.xmlsoft.org
TERMUX_PKG_DESCRIPTION="Library for parsing XML documents"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
_MAJOR_VERSION=2.13
TERMUX_PKG_VERSION=${_MAJOR_VERSION}.6
TERMUX_PKG_SRCURL=https://download.gnome.org/sources/libxml2/${_MAJOR_VERSION}/libxml2-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=f453480307524968f7a04ec65e64f2a83a825973bcd260a2e7691be82ae70c96
TERMUX_PKG_SETUP_PYTHON=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--with-python
--with-history
--with-icu
--with-threads
"
TERMUX_PKG_DEPENDS="libicu-glibc, ncurses-glibc, readline-glibc, zlib-glibc, liblzma-glibc"
TERMUX_PKG_SEPARATE_SUB_DEPENDS=true
