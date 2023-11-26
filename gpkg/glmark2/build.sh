TERMUX_PKG_HOMEPAGE=https://github.com/glmark2/glmark2
TERMUX_PKG_DESCRIPTION="glmark2 is an OpenGL 2.0 and ES 2.0 benchmark"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=2023.01
TERMUX_PKG_SRCURL=https://github.com/glmark2/glmark2/archive/refs/tags/${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=8fece3fc323b643644a525be163dc4931a4189971eda1de8ad4c1712c5db3d67
TERMUX_PKG_DEPENDS="opengl-glibc, libjpeg-turbo-glibc, libx11-glibc, libpng-glibc, libwayland-glibc"
TERMUX_PKG_BUILD_DEPENDS="libwayland-protocols-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Dflavors=x11-gl,x11-glesv2,x11-gl-egl,wayland-gl,wayland-glesv2
"
