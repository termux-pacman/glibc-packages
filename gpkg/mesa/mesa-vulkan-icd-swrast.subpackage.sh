TERMUX_SUBPKG_DESCRIPTION="Mesa's Swrast Vulkan ICD"
TERMUX_SUBPKG_DEPEND_ON_PARENT="no"
TERMUX_SUBPKG_DEPENDS="vulkan-icd-loader-glibc, gcc-libs-glibc, libllvm-glibc, zlib-glibc, zstd-glibc, libdrm-glibc, libexpat-glibc, libxcb-glibc, libwayland-glibc, libx11-glibc, libxshmfence-glibc"
TERMUX_SUBPKG_INCLUDE="
glibc/lib/libvulkan_lvp.so
glibc/share/vulkan/icd.d/lvp_icd.*.json
"
