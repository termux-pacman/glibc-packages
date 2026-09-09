TERMUX_PKG_HOMEPAGE=https://linux.thai.net/projects/datrie
TERMUX_PKG_DESCRIPTION="Double-array trie library"
TERMUX_PKG_LICENSE="LGPL-3.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=0.2.14
TERMUX_PKG_SRCURL=https://linux.thai.net/pub/thailinux/software/libthai/libdatrie-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=f04095010518635b51c2313efa4f290b7db828d6273e39b2b8858f859dfe81d5
TERMUX_PKG_DEPENDS="glibc, libiconv-glibc"
TERMUX_PKG_BUILD_DEPENDS="doxygen-glibc"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure() {
	CFLAGS+=" -liconv"
}
