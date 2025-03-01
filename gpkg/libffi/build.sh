TERMUX_PKG_HOMEPAGE=https://sourceware.org/libffi/
TERMUX_PKG_DESCRIPTION="Library providing a portable, high level programming interface to various calling conventions"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=3.4.7
TERMUX_PKG_SRCURL=https://github.com/libffi/libffi/releases/download/v${TERMUX_PKG_VERSION}/libffi-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=138607dee268bdecf374adf9144c00e839e38541f75f24a1fcf18b78fda48b2d
TERMUX_PKG_DEPENDS="glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-multi-os-directory
--disable-exec-static-tramp
--enable-pax_emutramp
"
