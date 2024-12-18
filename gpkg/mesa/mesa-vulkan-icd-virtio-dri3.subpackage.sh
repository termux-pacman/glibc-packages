TERMUX_SUBPKG_DESCRIPTION="Mesa's Virtio Vulkan ICD"
TERMUX_SUBPKG_DEPEND_ON_PARENT="no"
TERMUX_SUBPKG_DEPENDS="libandroid-shmem, libc++, libdrm, libx11, libxcb, libxshmfence, libwayland, vulkan-loader-generic, zlib, zstd"
TERMUX_SUBPKG_EXCLUDED_ARCHES="arm, i686, x86_64"
TERMUX_SUBPKG_INCLUDE="
lib/libvulkan_virtio.so
share/vulkan/icd.d/virtio_icd.*.json
"
