TERMUX_PKG_HOMEPAGE=https://sourceware.org/elfutils/
TERMUX_PKG_DESCRIPTION="ELF object file access library"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=0.192
TERMUX_PKG_SRCURL="https://sourceware.org/elfutils/ftp/${TERMUX_PKG_VERSION}/elfutils-${TERMUX_PKG_VERSION}.tar.bz2"
TERMUX_PKG_SHA256=616099beae24aba11f9b63d86ca6cc8d566d968b802391334c91df54eab416b4
TERMUX_PKG_DEPENDS="zlib-glibc, zstd-glibc"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--program-prefix="eu-"
--enable-deterministic-archives
--enable-maintainer-mode
"

termux_step_pre_configure() {
	CFLAGS+=" -ffat-lto-objects"
	autoreconf -ivf
}
