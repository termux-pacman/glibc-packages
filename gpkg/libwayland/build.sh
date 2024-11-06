TERMUX_PKG_HOMEPAGE=https://wayland.freedesktop.org/
TERMUX_PKG_DESCRIPTION="Wayland protocol library"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.23.1
TERMUX_PKG_SRCURL=https://gitlab.freedesktop.org/wayland/wayland/-/releases/${TERMUX_PKG_VERSION}/downloads/wayland-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=864fb2a8399e2d0ec39d56e9d9b753c093775beadc6022ce81f441929a81e5ed
TERMUX_PKG_DEPENDS="libffi-glibc, libexpat-glibc, libxml2-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="-Ddocumentation=false"
TERMUX_PKG_MESON_NATIVE=true
