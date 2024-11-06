TERMUX_PKG_HOMEPAGE="https://www.alsa-project.org"
TERMUX_PKG_DESCRIPTION="An alternative implementation of Linux sound support"
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.2.13
TERMUX_PKG_SRCURL=https://www.alsa-project.org/files/pub/lib/alsa-lib-$TERMUX_PKG_VERSION.tar.bz2
TERMUX_PKG_SHA256=8c4ff37553cbe89618e187e4c779f71a9bb2a8b27b91f87ed40987cc9233d8f6
TERMUX_PKG_DEPENDS="glibc"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--with-tmpdir=$TERMUX_PREFIX_CLASSICAL/tmp
--disable-static
"
