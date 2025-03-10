TERMUX_PKG_HOMEPAGE=https://boost.org
TERMUX_PKG_DESCRIPTION="Free peer-reviewed portable C++ source libraries"
TERMUX_PKG_LICENSE="BSL-1.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="1.87.0"
TERMUX_PKG_SRCURL=https://archives.boost.io/release/$TERMUX_PKG_VERSION/source/boost_${TERMUX_PKG_VERSION//./_}.tar.bz2
TERMUX_PKG_SHA256=af57be25cb4c4f4b413ed692fe378affb4352ea50fbe294a11ef548f4d527d89
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

	local ML_FLAG=""
	if [ "$TERMUX_ARCH" = i686 ]; then
		ML_FLAG="-DBOOST_STACKTRACE_LIBCXX_RUNTIME_MAY_CAUSE_MEMORY_LEAK"
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
		cflags="$CPPFLAGS $CFLAGS $ML_FLAG -fPIC -O3 -ffat-lto-objects" \
		cxxflags="$CPPFLAGS $CXXFLAGS $ML_FLAG -fPIC -O3 -ffat-lto-objects" \
		linkflags="$LDFLAGS" \
		--layout=system \
		--prefix=$TERMUX_PREFIX \
		architecture="$BOOSTARCH" \
		abi="$BOOSTABI" \
		address-model="$BOOSTAM"
}
