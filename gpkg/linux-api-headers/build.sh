TERMUX_PKG_HOMEPAGE=https://www.gnu.org/software/libc/
TERMUX_PKG_DESCRIPTION="Kernel headers sanitized for use in userspace"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=6.14
TERMUX_PKG_SRCURL=https://www.kernel.org/pub/linux/kernel/v${TERMUX_PKG_VERSION:0:1}.x/linux-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=a294b683e7b161bb0517bb32ec7ed1d2ea7603dfbabad135170ed12d00c47670
TERMUX_PKG_BUILD_MULTILIB=true

termux_step_make() {
	(
		if [ "$TERMUX_ON_DEVICE_BUILD" = "false" ]; then
			unset CFLAGS CXXFLAGS CC CXX AR RANLIB NM CXXFILT
			export PATH="/usr/bin"
		fi
		make -C "${TERMUX_PKG_SRCDIR}" ARCH="${LINUX_ARCH}" mrproper
	)
}

termux_step_make_install() {
	make -C "${TERMUX_PKG_SRCDIR}" INSTALL_HDR_PATH="${TERMUX__PREFIX__INCLUDE_DIR}" ARCH="${LINUX_ARCH}" headers_install
	rm -r "${TERMUX__PREFIX__INCLUDE_DIR}/drm"
}
