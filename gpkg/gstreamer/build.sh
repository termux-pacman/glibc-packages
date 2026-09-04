TERMUX_PKG_HOMEPAGE=https://gstreamer.freedesktop.org/
TERMUX_PKG_DESCRIPTION="Open source multimedia framework - core components"
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.24.9
TERMUX_PKG_SRCURL=https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=11c5e2c8a2434e69d91a72f223291b1b11513b0e5a47562248929410e5b38a18
TERMUX_PKG_DEPENDS="glibc, glib-glibc, libxml2-glibc, libcap-glibc, libunwind-glibc, gcc-libs-glibc"
TERMUX_PKG_BUILD_DEPENDS="gobject-introspection-glibc"
TERMUX_PKG_PYTHON_COMMON_DEPS="setuptools, pygments"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--default-library both
-D tools=enabled
-D examples=disabled
-D tests=disabled
-D docs=disabled
-D introspection=enabled
-D benchmarks=disabled
-D dbus=enabled
-D ptp-helper-permissions=none
-D package-name=GStreamer
-D package-origin=https://termux-pacman.dev
-D debug=false
-D b_ndebug=if-release
"
