TERMUX_PKG_HOMEPAGE=libvdpau
TERMUX_PKG_DESCRIPTION="Nvidia VDPAU library"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.5
TERMUX_PKG_SRCURL=https://gitlab.freedesktop.org/vdpau/libvdpau/-/archive/$TERMUX_PKG_VERSION/libvdpau-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=66490802f30426d30ff9e8af35263bbbbaa23b52d0a2d797d06959c3d19638fd
TERMUX_PKG_DEPENDS="libxext-glibc"
TERMUX_PKG_BUILD_DEPENDS="xorgproto-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--prefix=$TERMUX_PREFIX
"

termux_step_pre_configure() {
	termux_setup_meson
	termux_setup_ninja
}
