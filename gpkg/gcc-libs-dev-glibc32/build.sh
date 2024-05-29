TERMUX_PKG_HOMEPAGE=https://gcc.gnu.org/
TERMUX_PKG_DESCRIPTION="Runtime libraries shipped by GCC on a 32-bit basis (temporary package)"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=15.1.0
TERMUX_PKG_SKIP_SRC_EXTRACT=true
TERMUX_PKG_BUILD_MULTILIB=true
TERMUX_PKG_EXCLUDED_ARCHES="arm, i686"

termux_step_make_install() {
	mkdir -p ${TERMUX__PREFIX__LIB_DIR}
	cp -r ${CGCT_DIR}/${TERMUX_ARCH}/lib/lib* ${TERMUX__PREFIX__LIB_DIR}
}
