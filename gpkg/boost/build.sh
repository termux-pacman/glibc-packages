TERMUX_PKG_HOMEPAGE=https://boost.org
TERMUX_PKG_DESCRIPTION="Free peer-reviewed portable C++ source libraries"
TERMUX_PKG_LICENSE="BSL-1.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="1.83.0"
TERMUX_PKG_SRCURL=https://boostorg.jfrog.io/artifactory/main/release/$TERMUX_PKG_VERSION/source/boost_${TERMUX_PKG_VERSION//./_}.tar.bz2
TERMUX_PKG_SHA256=6478edfe2f3305127cffe8caf73ea0176c53769f4bf1585be237eb30798c3b8e
TERMUX_PKG_DEPENDS="libbz2-glibc, zlib-glibc, libicu-glibc, zstd-glibc"
TERMUX_PKG_BUILD_DEPENDS="python-glibc"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make_install() {
	local python_version=$($TERMUX_PREFIX/bin/python -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')

	if [ "$TERMUX_ARCH" = arm ] || [ "$TERMUX_ARCH" = aarch64 ]; then
		local BOOSTARCH=arm
		local BOOSTABI=aapcs
	elif [ "$TERMUX_ARCH" = i686 ] || [ "$TERMUX_ARCH" = x86_64 ]; then
		local BOOSTARCH=x86
		local BOOSTABI=sysv
	fi

	if [ "$TERMUX_ARCH" = x86_64 ] || [ "$TERMUX_ARCH" = aarch64 ]; then
		local BOOSTAM=64
	elif [ "$TERMUX_ARCH" = i686 ] || [ "$TERMUX_ARCH" = arm ]; then
		local BOOSTAM=32
	fi

	./bootstrap.sh --with-toolset=gcc --with-icu --with-python=$TERMUX_PREFIX/bin/python3
	./b2 install \
		variant=release \
		debug-symbols=off \
		threading=multi \
		runtime-link=shared \
		link=shared,static \
		toolset=gcc \
		python=$python_version \
		cflags="$CPPFLAGS $CFLAGS -fPIC -O3 -ffat-lto-objects" \
		cxxflags="$CPPFLAGS $CXXFLAGS -fPIC -O3 -ffat-lto-objects" \
		linkflags="$LDFLAGS" \
		--layout=system \
		--prefix=$TERMUX_PREFIX \
		architecture="$BOOSTARCH" \
		abi="$BOOSTABI" \
		address-model="$BOOSTAM"
}
