TERMUX_PKG_HOMEPAGE=https://github.com/facebook/zstd
TERMUX_PKG_DESCRIPTION="Zstandard compression"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="1.5.6"
TERMUX_PKG_SRCURL=https://github.com/facebook/zstd/archive/v$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=30f35f71c1203369dc979ecde0400ffea93c27391bfd2ac5a9715d2173d92ff7
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
