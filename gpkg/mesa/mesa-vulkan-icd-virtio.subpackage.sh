TERMUX_SUBPKG_DESCRIPTION="Mesa's project Venus client driver ICD. enable with VN_DEBUG=all"
TERMUX_SUBPKG_DEPEND_ON_PARENT="no"
TERMUX_SUBPKG_DEPENDS="vulkan-icd-loader-glibc, gcc-libs-glibc, libllvm-glibc, zlib-glibc, zstd-glibc, libdrm-glibc, libexpat-glibc, libxcb-glibc, libwayland-glibc, libx11-glibc, libxshmfence-glibc"
TERMUX_SUBPKG_INCLUDE="
glibc/lib/libvulkan_virtio.so
glibc/share/vulkan/icd.d/virtio_icd.*.json
"
