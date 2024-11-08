TERMUX_PKG_HOMEPAGE=https://llvm.org/
TERMUX_PKG_DESCRIPTION="Compiler runtime libraries for clang"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_LICENSE_FILE="LICENSE.TXT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=19.1.3
_SOURCE=https://github.com/llvm/llvm-project/releases/download/llvmorg-$TERMUX_PKG_VERSION
TERMUX_PKG_SRCURL=($_SOURCE/compiler-rt-$TERMUX_PKG_VERSION.src.tar.xz
		$_SOURCE/cmake-$TERMUX_PKG_VERSION.src.tar.xz)
TERMUX_PKG_SHA256=(9c57dfa7796c254f85ade3f84f12e3a7dd5dae65c0ade428367fe8c5218f856a
		4c55aa6e77fc0e8b759bca2c79ee4fd0ea8c7fab06eeea09310ae1e954a0af5e)
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
