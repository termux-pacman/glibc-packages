TERMUX_PKG_HOMEPAGE=https://www.bytereef.org/mpdecimal/index.html
TERMUX_PKG_DESCRIPTION="Package for correctly-rounded arbitrary precision decimal floating point arithmetic"
TERMUX_PKG_LICENSE="BSD"
TERMUX_PKG_LICENSE_FILE="COPYRIGHT.txt"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=4.0.1
TERMUX_PKG_SRCURL=https://www.bytereef.org/software/mpdecimal/releases/mpdecimal-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=96d33abb4bb0070c7be0fed4246cd38416188325f820468214471938545b1ac8
TERMUX_PKG_DEPENDS="gcc-libs-glibc"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure() {
	LD=$CC
}
