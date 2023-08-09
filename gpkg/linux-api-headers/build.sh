TERMUX_PKG_HOMEPAGE=https://www.gnu.org/software/libc/
TERMUX_PKG_DESCRIPTION="Kernel headers sanitized for use in userspace"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=6.4
TERMUX_PKG_SRCURL=https://www.kernel.org/pub/linux/kernel/v${TERMUX_PKG_VERSION:0:1}.x/linux-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=8fa0588f0c2ceca44cac77a0e39ba48c9f00a6b9dc69761c02a5d3efac8da7f3
TERMUX_PKG_BUILD_IN_SRC=true

_target_arch="x86"
case "${TERMUX_ARCH}" in
	"aarch64") _target_arch="arm64";;
	"arm") _target_arch="arm";;
esac

termux_step_make() {
	make ARCH=${_target_arch} CROSS_COMPILE="${TERMUX_HOST_PLATFORM}-" mrproper
}

termux_step_make_install() {
	make INSTALL_HDR_PATH="${TERMUX_PREFIX}" ARCH=${_target_arch} HOSTCC=${CC} HOSTCXX=${CXX} headers_install

	rm -r "$TERMUX_PREFIX/include/drm"
}
