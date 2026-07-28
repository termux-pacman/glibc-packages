TERMUX_PKG_HOMEPAGE=https://darwinsys.com/file/
TERMUX_PKG_DESCRIPTION="Command-line tool that tells you in words what kind of data a file contains"
TERMUX_PKG_LICENSE="BSD 2-Clause"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=5.48
TERMUX_PKG_SRCURL=ftp://ftp.astron.com/pub/file/file-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=ed14656883b23a364b4057c05595d93252da9bc473d30106519519d0da141283
TERMUX_PKG_DEPENDS="libseccomp-glibc, zstd-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--enable-fsect-man5
--enable-libseccomp
"
#TERMUX_PKG_GROUPS="base-devel"
