TERMUX_PKG_HOMEPAGE=https://www.gnu.org/software/libc/
TERMUX_PKG_DESCRIPTION="Kernel headers sanitized for use in userspace"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=6.7
TERMUX_PKG_SRCURL=https://www.kernel.org/pub/linux/kernel/v${TERMUX_PKG_VERSION:0:1}.x/linux-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=ef31144a2576d080d8c31698e83ec9f66bf97c677fa2aaf0d5bbb9f3345b1069
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
