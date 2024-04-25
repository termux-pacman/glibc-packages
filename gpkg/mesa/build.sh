TERMUX_PKG_HOMEPAGE="https://www.mesa3d.org"
TERMUX_PKG_DESCRIPTION="An open-source implementation of the OpenGL specification"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_LICENSE_FILE="docs/license.rst"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="24.0.4"
TERMUX_PKG_SRCURL="https://archive.mesa3d.org/mesa-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="90febd30a098cbcd97ff62ecc3dcf5c93d76f7fa314de944cfce81951ba745f0"
TERMUX_PKG_DEPENDS="libglvnd-glibc, gcc-libs-glibc, libdrm-glibc, libllvm-glibc, libexpat-glibc, zlib-glibc, zstd-glibc, libx11-glibc, libxcb-glibc, libxext-glibc, libxfixes-glibc, libxshmfence-glibc, libxxf86vm-glibc, libwayland-glibc, libvdpau-glibc, libomxil-bellagio-glibc, libva-glibc, libxml2-glibc, libelf-glibc, libbz2-glibc, libclc-glibc"
TERMUX_PKG_SUGGESTS="mesa-dev-glibc"
TERMUX_PKG_BUILD_DEPENDS="llvm-glibc, libwayland-protocols-glibc, xorgproto-glibc, glslang-glibc"
TERMUX_PKG_PYTHON_COMMON_DEPS="mako"
# disabling libunwind, microsoft-clc and valgrind will improve performance

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-D android-libbacktrace=disabled
-D b_ndebug=true
-D dri3=enabled
-D egl=enabled
-D gallium-opencl=icd
-D gallium-drivers=freedreno,swrast,virgl,zink,r600,radeonsi,nouveau,lima,panfrost
-D gallium-extra-hud=true
-D gallium-nine=true
-D gallium-va=enabled
-D gallium-vdpau=enabled
-D gallium-omx=bellagio
-D gallium-xa=disabled
-D gbm=enabled
-D gles1=enabled
-D gles2=enabled
-D glvnd=true
-D glx=dri
-D intel-clc=disabled
-D libunwind=disabled
-D llvm=enabled
-D microsoft-clc=disabled
-D osmesa=true
-D platforms=x11,wayland
-D shared-glapi=enabled
-D valgrind=disabled
-D vulkan-layers=device-select,overlay
"

termux_step_pre_configure() {
	case $TERMUX_ARCH in
		arm|aarch64) TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" -Dvulkan-drivers=swrast,panfrost,freedreno -Dfreedreno-kmds=msm,kgsl";;
		*) TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" -Dvulkan-drivers=swrast,panfrost";;
	esac
	export LLVM_CONFIG=$TERMUX_PREFIX/bin/llvm-config
}
