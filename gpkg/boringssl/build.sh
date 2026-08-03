TERMUX_PKG_SRCURL=git+https://github.com/john-peterson/boringssl
TERMUX_PKG_GIT_BRANCH=imp

# TERMUX_PKG_SRCURL=git+https://github.com/google/boringssl
# TERMUX_PKG_GIT_BRANCH=main

TERMUX_PKG_DESCRIPTION="boring ssl"
TERMUX_PKG_VERSION=0
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_BUILD_DEPENDS="golang"
# TERMUX_PKG_DEPENDS="libnghttp2, libnghttp3, libssh2, openssl (>= 1:3.2.1-1), zlib"
TERMUX_PKG_DEPENDS="ca-certificates, zlib-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS=" -DCMAKE_INSTALL_PREFIX=$TERMUX_PREFIX/opt/boringssl -DCMAKE_INSTALL_LIBDIR=$TERMUX_PREFIX/opt/boringssl/lib -DBUILD_SHARED_LIBS=ON"
# TERMUX_PKG_EXTRA_MAKE_ARGS=" -j2 "
TERMUX_PKG_MAKE_PROCESSES=2

termux_step_pre_configure() {
export CXXFLAGS="-w -Wno-error"
# export CFLAGS=-fno-exceptions
	sed -i "s,-Werror,,g" CMakeLists.txt
:
}

# termux_step_configure() { :; }

termux_step_post_configure() {
	sed -i "s,-Werror ,,g" ../build/build.ninja
: 
}

# termux_step_make() { 

# }


termux_step_post_make_install() {
	# mkdir $TERMUX_PREFIX/opt/boringssl
	# mv $TERMUX_PREFIX/lib/libcrypto.so $TERMUX_PREFIX/opt/boringssl
	# mv $TERMUX_PREFIX/lib/libssl.so $TERMUX_PREFIX/opt/boringssl
	:
}

# termux_step_extract_into_massagedir() { :; }

# termux_step_post_massage() { :; }


