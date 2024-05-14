TERMUX_PKG_HOMEPAGE=http://www.xmlsoft.org
TERMUX_PKG_DESCRIPTION="Library for parsing XML documents"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
_MAJOR_VERSION=2.12
TERMUX_PKG_VERSION=${_MAJOR_VERSION}.7
TERMUX_PKG_SRCURL=https://download.gnome.org/sources/libxml2/${_MAJOR_VERSION}/libxml2-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=24ae78ff1363a973e6d8beba941a7945da2ac056e19b53956aeb6927fd6cfb56
TERMUX_PKG_SETUP_PYTHON=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--with-python
--with-history
--with-icu
--with-threads
"
TERMUX_PKG_DEPENDS="libicu-glibc, ncurses-glibc, readline-glibc, zlib-glibc, liblzma-glibc"
TERMUX_PKG_SEPARATE_SUB_DEPENDS=true
