TERMUX_PKG_HOMEPAGE=https://www.bytereef.org/mpdecimal/index.html
TERMUX_PKG_DESCRIPTION="Package for correctly-rounded arbitrary precision decimal floating point arithmetic"
TERMUX_PKG_LICENSE="BSD"
TERMUX_PKG_LICENSE_FILE="COPYRIGHT.txt"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=4.0.0
TERMUX_PKG_SRCURL=https://www.bytereef.org/software/mpdecimal/releases/mpdecimal-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=942445c3245b22730fd41a67a7c5c231d11cb1b9936b9c0f76334fb7d0b4468c
TERMUX_PKG_DEPENDS="gcc-libs-glibc"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure() {
	if [ "$TERMUX_ARCH" = "i686" ]; then
		# error of ld: undefined reference to `__stack_chk_fail_local'
		CFLAGS+=" -fno-stack-protector"
	fi
}
