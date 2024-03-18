TERMUX_PKG_HOMEPAGE=https://sourceware.org/libffi/
TERMUX_PKG_DESCRIPTION="Library providing a portable, high level programming interface to various calling conventions"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=3.4.6
TERMUX_PKG_SRCURL=https://github.com/libffi/libffi/releases/download/v${TERMUX_PKG_VERSION}/libffi-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=b0dea9df23c863a7a50e825440f3ebffabd65df1497108e5d437747843895a4e
TERMUX_PKG_DEPENDS="glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-multi-os-directory
--disable-exec-static-tramp
--enable-pax_emutramp
"
