TERMUX_PKG_HOMEPAGE=https://gcc.gnu.org/
TERMUX_PKG_DESCRIPTION="Runtime libraries shipped by GCC (temporary package)"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=13.2.0
TERMUX_PKG_SKIP_SRC_EXTRACT=true
TERMUX_PKG_ESSENTIAL=true

termux_step_make_install() {
	cp -r ${CGCT_DIR}/${TERMUX_ARCH}/lib/lib* ${TERMUX_PREFIX}/lib
}
