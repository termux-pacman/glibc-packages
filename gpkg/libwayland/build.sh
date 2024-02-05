TERMUX_PKG_HOMEPAGE=https://wayland.freedesktop.org/
TERMUX_PKG_DESCRIPTION="Wayland protocol library"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.22.0
TERMUX_PKG_SRCURL=https://gitlab.freedesktop.org/wayland/wayland/-/releases/${TERMUX_PKG_VERSION}/downloads/wayland-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=1540af1ea698a471c2d8e9d288332c7e0fd360c8f1d12936ebb7e7cbc2425842
TERMUX_PKG_DEPENDS="libffi-glibc, libexpat-glibc, libxml2-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="-Ddocumentation=false"
