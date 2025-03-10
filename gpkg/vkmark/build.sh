TERMUX_PKG_HOMEPAGE=https://github.com/vkmark/vkmark
TERMUX_PKG_DESCRIPTION="vkmark is an extensible Vulkan benchmarking suite with targeted, configurable scenes."
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=2025.01
TERMUX_PKG_SRCURL=https://github.com/vkmark/vkmark/archive/refs/tags/$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=1ae362844344d0f9878b7a3f13005f77eae705108892a4e8abf237d452d37edc
TERMUX_PKG_DEPENDS="vulkan-icd-loader-glibc, gcc-libs-glibc, assimp-glibc, xcb-util-wm-glibc, libwayland-glibc"
TERMUX_PKG_BUILD_DEPENDS="vulkan-headers-glibc, xorgproto-glibc, libwayland-protocols-glibc, glm-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="-Dkms=false"
