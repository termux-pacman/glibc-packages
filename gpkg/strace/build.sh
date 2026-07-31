TERMUX_PKG_HOMEPAGE=https://strace.io/
TERMUX_PKG_DESCRIPTION="Debugging utility to monitor system calls and signals received"
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_LICENSE_FILE="COPYING, LGPL-2.1-or-later"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="7.1"
TERMUX_PKG_SRCURL=https://github.com/strace/strace/releases/download/v$TERMUX_PKG_VERSION/strace-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=81743ecf2a5b44186b2f5038afdc8beda7e5c70aed15b4fbfbcc6e9ece24490f
TERMUX_PKG_DEPENDS="perl-glibc, libunwind-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--with-libunwind
--enable-mpers=no
"
