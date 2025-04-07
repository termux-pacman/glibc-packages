TERMUX_PKG_HOMEPAGE=https://tracker.debian.org/pkg/fakeroot
TERMUX_PKG_DESCRIPTION="Tool for simulating superuser privileges"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.37.1.1
TERMUX_PKG_SRCURL=https://salsa.debian.org/clint/fakeroot/-/archive/upstream/${TERMUX_PKG_VERSION}/fakeroot-upstream-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=caeef85642445245e4e994ce3633d21718a0baf16d5398e280b3149cbfcfae35
TERMUX_PKG_DEPENDS="sed-glibc, util-linux-glibc, bash-glibc, libcap-glibc"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
--with-ipc=tcp
"

termux_step_pre_configure() {
	autoreconf -fi
	(
		cd doc
		for i in */; do
			ln -s ../faked.1 "./${i}"
			ln -s ../fakeroot.1 "./${i}"
		done
	)
}

termux_step_post_make_install() {
	ln -sfr "${TERMUX_PREFIX}/lib/libfakeroot-0.so" "${TERMUX_PREFIX}/lib/libfakeroot.so"
}
