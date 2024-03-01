TERMUX_PKG_HOMEPAGE=https://darwinsys.com/file/
TERMUX_PKG_DESCRIPTION="Command-line tool that tells you in words what kind of data a file contains"
TERMUX_PKG_LICENSE="BSD 2-Clause"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=5.45
TERMUX_PKG_SRCURL=ftp://ftp.astron.com/pub/file/file-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=fc97f51029bb0e2c9f4e3bffefdaf678f0e039ee872b9de5c002a6d09c784d82
TERMUX_PKG_DEPENDS="libseccomp-glibc, zstd-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--enable-fsect-man5
--enable-libseccomp
"
#TERMUX_PKG_GROUPS="base-devel"
