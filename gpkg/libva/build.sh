TERMUX_PKG_HOMEPAGE=https://01.org/linuxmedia/vaapi
TERMUX_PKG_DESCRIPTION="Video Acceleration (VA) API for Linux"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=2.22.0
TERMUX_PKG_SRCURL=https://github.com/intel/libva/archive/refs/tags/${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=467c418c2640a178c6baad5be2e00d569842123763b80507721ab87eb7af8735
TERMUX_PKG_DEPENDS="libdrm-glibc, libglvnd-glibc, libx11-glibc, libxext-glibc, libxfixes-glibc, libwayland-glibc"

termux_step_configure() {
	CFLAGS+=" -DENABLE_VA_MESSAGING"
	termux_step_configure_meson
}
