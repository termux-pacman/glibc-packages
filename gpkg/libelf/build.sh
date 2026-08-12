TERMUX_PKG_HOMEPAGE=https://sourceware.org/elfutils/
TERMUX_PKG_DESCRIPTION="ELF object file access library"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=0.193
TERMUX_PKG_SRCURL="https://sourceware.org/elfutils/ftp/${TERMUX_PKG_VERSION}/elfutils-${TERMUX_PKG_VERSION}.tar.bz2"
TERMUX_PKG_SHA256=7857f44b624f4d8d421df851aaae7b1402cfe6bcdd2d8049f15fc07d3dde7635
TERMUX_PKG_DEPENDS="zlib-glibc, zstd-glibc"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--program-prefix="eu-"
--enable-deterministic-archives
--enable-maintainer-mode
"

termux_step_pre_configure() {
	CFLAGS+=" -ffat-lto-objects -Wno-discarded-qualifiers -Wno-unused-but-set-variable"
	autoreconf -ivf
}
