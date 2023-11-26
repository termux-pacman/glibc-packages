TERMUX_PKG_HOMEPAGE=https://01.org/linuxmedia/vaapi
TERMUX_PKG_DESCRIPTION="Video Acceleration (VA) API for Linux"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=2.20.0
TERMUX_PKG_SRCURL=https://github.com/intel/libva/releases/download/$TERMUX_PKG_VERSION/libva-$TERMUX_PKG_VERSION.tar.bz2
TERMUX_PKG_SHA256=f72bdb4f48dfe71ad01f1cbefe069672a2c949a6abd51cf3c4d4784210badc49
TERMUX_PKG_DEPENDS="libdrm-glibc, libglvnd-glibc, libx11-glibc, libxext-glibc, libxfixes-glibc, libwayland-glibc"

termux_step_configure() {
	CFLAGS+=" -DENABLE_VA_MESSAGING"
	termux_step_configure_meson
}
