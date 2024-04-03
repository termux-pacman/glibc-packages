TERMUX_PKG_HOMEPAGE=https://strace.io/
TERMUX_PKG_DESCRIPTION="Debugging utility to monitor system calls and signals received"
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_LICENSE_FILE="COPYING, LGPL-2.1-or-later"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="6.8"
TERMUX_PKG_SRCURL=https://github.com/strace/strace/releases/download/v$TERMUX_PKG_VERSION/strace-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=ba6950a96824cdf93a584fa04f0a733896d2a6bc5f0ad9ffe505d9b41e970149
TERMUX_PKG_DEPENDS="perl-glibc, libunwind-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--with-libunwind
--enable-mpers=no
"
