TERMUX_PKG_HOMEPAGE=https://sourceware.org/elfutils/
TERMUX_PKG_DESCRIPTION="ELF object file access library"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=0.196
TERMUX_PKG_SRCURL="https://sourceware.org/elfutils/ftp/${TERMUX_PKG_VERSION}/elfutils-${TERMUX_PKG_VERSION}.tar.bz2"
TERMUX_PKG_SHA256=fd5cc6b77ad6773cac93cb3f415f9318ac3b3455eecf801f6b4a742c4f6c7209
TERMUX_PKG_DEPENDS="zlib-glibc, zstd-glibc"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--program-prefix="eu-"
--enable-deterministic-archives
--enable-maintainer-mode
"

termux_step_pre_configure() {
	CFLAGS+=" -ffat-lto-objects -Wno-discarded-qualifiers -Wno-unused-but-set-variable"
	CXXFLAGS+=" -L${TERMUX_STANDALONE_TOOLCHAIN}/lib"
	autoreconf -ivf
}
