TERMUX_PKG_HOMEPAGE=https://llvm.org/
TERMUX_PKG_DESCRIPTION="Compiler runtime libraries for clang"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_LICENSE_FILE="LICENSE.TXT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=18.1.7
_SOURCE=https://github.com/llvm/llvm-project/releases/download/llvmorg-$TERMUX_PKG_VERSION
TERMUX_PKG_SRCURL=($_SOURCE/compiler-rt-$TERMUX_PKG_VERSION.src.tar.xz
		$_SOURCE/cmake-$TERMUX_PKG_VERSION.src.tar.xz)
TERMUX_PKG_SHA256=(7df49e669b0e93d183f5c0fcf01a4b5bbeeeb90304afffbdd84d4871da6b6e98
		f0b67599f51cddcdbe604c35b6de97f2d0a447e18b9c30df300c82bf1ee25bd7)
TERMUX_PKG_DEPENDS="gcc-libs-glibc"
TERMUX_PKG_BUILD_DEPENDS="llvm-glibc, python-glibc"
TERMUX_PKG_NO_STATICSPLIT=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCOMPILER_RT_INSTALL_PATH=$TERMUX_PREFIX/lib/clang/${TERMUX_PKG_VERSION%%.*}
"

termux_step_post_get_source() {
	for i in cmake; do
		rm -fr $TERMUX_TOPDIR/$TERMUX_PKG_NAME/${i}
		mv $TERMUX_PKG_SRCDIR/$i-$TERMUX_PKG_VERSION.src $TERMUX_TOPDIR/$TERMUX_PKG_NAME
		mv $TERMUX_TOPDIR/$TERMUX_PKG_NAME/$i-$TERMUX_PKG_VERSION.src $TERMUX_TOPDIR/$TERMUX_PKG_NAME/$i
	done
}

termux_step_pre_configure() {
	termux_setup_cmake
	termux_setup_ninja
}
