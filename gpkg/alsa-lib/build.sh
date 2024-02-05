TERMUX_PKG_HOMEPAGE="https://www.alsa-project.org"
TERMUX_PKG_DESCRIPTION="An alternative implementation of Linux sound support"
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.2.10
TERMUX_PKG_SRCURL="https://www.alsa-project.org/files/pub/lib/alsa-lib-$TERMUX_PKG_VERSION.tar.bz2"
TERMUX_PKG_SHA256="c86a45a846331b1b0aa6e6be100be2a7aef92efd405cf6bac7eef8174baa920e"
TERMUX_PKG_DEPENDS="glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--with-tmpdir=$TERMUX_PREFIX_CLASSICAL/tmp
--disable-static
"
