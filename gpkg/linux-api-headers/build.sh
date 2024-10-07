TERMUX_PKG_HOMEPAGE=https://www.gnu.org/software/libc/
TERMUX_PKG_DESCRIPTION="Kernel headers sanitized for use in userspace"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=6.10
TERMUX_PKG_SRCURL=https://www.kernel.org/pub/linux/kernel/v${TERMUX_PKG_VERSION:0:1}.x/linux-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=774698422ee54c5f1e704456f37c65c06b51b4e9a8b0866f34580d86fef8e226

_target_arch="x86"
case "${TERMUX_ARCH}" in
	"aarch64") _target_arch="arm64";;
	"arm") _target_arch="arm";;
esac

termux_step_make() {
	make -C $TERMUX_PKG_SRCDIR ARCH=${_target_arch} CROSS_COMPILE="${TERMUX_HOST_PLATFORM}-" mrproper
}

termux_step_make_install() {
	make -C $TERMUX_PKG_SRCDIR INSTALL_HDR_PATH="$TERMUX_PREFIX" ARCH=${_target_arch} HOSTCC=${CC} HOSTCXX=${CXX} headers_install
	rm -r $TERMUX_PREFIX/include/drm

	if [ "$TERMUX_ARCH" = "aarch64" ]; then
		make -C $TERMUX_PKG_SRCDIR INSTALL_HDR_PATH="$TERMUX_PKG_BUILDDIR" ARCH=arm HOSTCC=${CC} HOSTCXX=${CXX} headers_install
		mkdir -p $TERMUX_PREFIX/include32
		cp -r $TERMUX_PKG_BUILDDIR/include/asm $TERMUX_PREFIX/include32
	fi
}
