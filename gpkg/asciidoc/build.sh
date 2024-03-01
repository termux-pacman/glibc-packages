TERMUX_PKG_HOMEPAGE=https://asciidoc.org
TERMUX_PKG_DESCRIPTION="Text document format for short documents, articles, books and UNIX man pages."
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="10.2.0"
TERMUX_PKG_SRCURL=https://github.com/asciidoc/asciidoc-py3/archive/${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=684ea53c1f5b71d6d1ac6086bbc96906b1f709ecc7ab536615b0f0c9e1baa3cc
TERMUX_PKG_DEPENDS="docbook-xsl-glibc, libxml2-utils-glibc, python-glibc, xsltproc-glibc"
TERMUX_PKG_PLATFORM_INDEPENDENT=true
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_PYTHON_COMMON_DEPS="wheel"
