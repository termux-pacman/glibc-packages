TERMUX_PKG_HOMEPAGE=https://www.bytereef.org/mpdecimal/index.html
TERMUX_PKG_DESCRIPTION="Package for correctly-rounded arbitrary precision decimal floating point arithmetic"
TERMUX_PKG_LICENSE="BSD"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=2.5.1
TERMUX_PKG_SRCURL=https://www.bytereef.org/software/mpdecimal/releases/mpdecimal-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=9f9cd4c041f99b5c49ffb7b59d9f12d95b683d88585608aa56a6307667b2b21f
TERMUX_PKG_DEPENDS="gcc-libs-glibc"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure() {
	if [ "$TERMUX_ARCH" = "i686" ]; then
		# error of ld: undefined reference to `__stack_chk_fail_local'
		CFLAGS+=" -fno-stack-protector"
	fi
}
