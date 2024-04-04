TERMUX_PKG_HOMEPAGE=https://cmake.org/
TERMUX_PKG_DESCRIPTION="Family of tools designed to build, test and package software"
TERMUX_PKG_LICENSE="BSD 3-Clause"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=3.29.1
TERMUX_PKG_SRCURL=https://www.cmake.org/files/v${TERMUX_PKG_VERSION:0:4}/cmake-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=7fb02e8f57b62b39aa6b4cf71e820148ba1a23724888494735021e32ab0eefcc
TERMUX_PKG_DEPENDS="libcurl-glibc, libarchive-glibc, jsoncpp-glibc, libuv-glibc, rhash-glibc, cppdap-glibc, libexpat-glibc"
TERMUX_PKG_RECOMMENDS="gcc-glibc, make-glibc"
TERMUX_PKG_FORCE_CMAKE=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DSPHINX_MAN=ON
-DSPHINX_HTML=ON
-DCMAKE_MAN_DIR=share/man
-DCMAKE_DOC_DIR=share/doc/cmake
-DCMAKE_USE_SYSTEM_CURL=ON
-DCMAKE_USE_SYSTEM_EXPAT=ON
-DCMAKE_USE_SYSTEM_FORM=ON
-DCMAKE_USE_SYSTEM_JSONCPP=ON
-DCMAKE_USE_SYSTEM_LIBARCHIVE=ON
-DCMAKE_USE_SYSTEM_LIBRHASH=ON
-DCMAKE_USE_SYSTEM_LIBUV=ON
-DCMAKE_USE_SYSTEM_ZLIB=ON
-DCMAKE_USE_SYSTEM_CPPDAP=ON
-DBUILD_CursesDialog=ON
-DCMake_ENABLE_DEBUGGER=ON
"

termux_step_pre_configure() {
	# for some reason this library is not used when compiling for x86_64
	# looks like this is a bug from cgt
	LDFLAGS+=" -lnghttp2 -lssl -lcrypto"
}
