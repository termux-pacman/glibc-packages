TERMUX_PKG_HOMEPAGE=https://www.gnu.org/software/make/
TERMUX_PKG_DESCRIPTION="Tool to control the generation of non-source files from source files"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
# Update both make and make-guile to the same version in one PR.
TERMUX_PKG_VERSION=4.4.1
TERMUX_PKG_SRCURL=https://mirrors.kernel.org/gnu/make/make-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=dd16fb1d67bfab79a72f5e8390735c49e3e8e70b4945a15ab1f81ddb78658fb3
TERMUX_PKG_DEPENDS="glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--without-guile"

termux_step_make() {
	# Allow to bootstrap make if building on device without make installed.
	if $TERMUX_ON_DEVICE_BUILD && [ -z "$(command -v make)" ]; then
		./build.sh
	else
		make -j $TERMUX_MAKE_PROCESSES
	fi
}

termux_step_make_install() {
	if $TERMUX_ON_DEVICE_BUILD && [ -z "$(command -v make)" ]; then
		./make -j 1 install
	else
		make -j 1 install
	fi
}
