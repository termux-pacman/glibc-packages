TERMUX_PKG_HOMEPAGE=https://github.com/facebook/zstd
TERMUX_PKG_DESCRIPTION="Zstandard compression"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="1.5.7"
TERMUX_PKG_SRCURL=https://github.com/facebook/zstd/archive/v$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=37d7284556b20954e56e1ca85b80226768902e2edabd3b649e9e72c0c9012ee3
TERMUX_PKG_DEPENDS="liblzma-glibc, zlib-glibc, liblz4-glibc, gcc-libs-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Ddefault_library=both
-Dbin_programs=true
-Dbin_tests=false
-Dbin_contrib=true
-Dzlib=enabled
-Dlzma=enabled
-Dlz4=enabled
"

termux_step_pre_configure() {
	TERMUX_PKG_SRCDIR+="/build/meson"
}
