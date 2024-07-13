diff --git a/src/freedreno/vulkan/tu_wsi.cc b/src/freedreno/vulkan/tu_wsi.cc
index 9929993bbe0..85c744585a8 100644
--- a/src/freedreno/vulkan/tu_wsi.cc
+++ b/src/freedreno/vulkan/tu_wsi.cc
@@ -14,6 +14,18 @@
 
 #include "tu_device.h"
 
+static void
+kgsl_get_info(VkPhysicalDevice _pdevice,
+                       VkDeviceMemory _memory,
+                       int *fd,
+                       uint32_t *offset)
+{
+   VK_FROM_HANDLE(tu_physical_device, pdevice, _pdevice);
+   VK_FROM_HANDLE(tu_device_memory, memory, _memory);
+   *fd = pdevice->local_fd;
+   *offset = memory->bo->gem_handle << 12;
+}
+
 static VKAPI_ATTR PFN_vkVoidFunction VKAPI_CALL
 tu_wsi_proc_addr(VkPhysicalDevice physicalDevice, const char *pName)
 {
@@ -45,6 +57,11 @@ tu_wsi_init(struct tu_physical_device *physical_device)
    if (result != VK_SUCCESS)
       return result;
 
+   if (strcmp(physical_device->instance->knl->name, "kgsl") == 0) {
+      physical_device->wsi_device.kgsl_get_info = kgsl_get_info;
+      physical_device->wsi_device.is_tu_kgsl = true;
+   }
+
    physical_device->wsi_device.supports_modifiers = true;
    physical_device->wsi_device.can_present_on_device =
       tu_wsi_can_present_on_device;
diff --git a/src/vulkan/wsi/wsi_common.c b/src/vulkan/wsi/wsi_common.c
index 726862560e8..3539a585d22 100644
--- a/src/vulkan/wsi/wsi_common.c
+++ b/src/vulkan/wsi/wsi_common.c
@@ -1424,7 +1424,7 @@ wsi_common_queue_present(const struct wsi_device *wsi,
       assert(!has_signal_dma_buf);
 #endif
 
-      if (wsi->sw)
+      if (wsi->sw || (wsi->is_tu_kgsl && !has_signal_dma_buf))
 	      wsi->WaitForFences(device, 1, &swapchain->fences[image_index],
 				 true, ~0ull);
 
diff --git a/src/vulkan/wsi/wsi_common.h b/src/vulkan/wsi/wsi_common.h
index 346025602b9..fbf22a736c1 100644
--- a/src/vulkan/wsi/wsi_common.h
+++ b/src/vulkan/wsi/wsi_common.h
@@ -168,6 +168,7 @@ struct wsi_device {
    } win32;
 
    bool sw;
+   bool is_tu_kgsl;
 
    /* Set to true if the implementation is ok with linear WSI images. */
    bool wants_linear;
@@ -221,6 +222,11 @@ struct wsi_device {
     */
    VkQueue (*get_blit_queue)(VkDevice device);
 
+   void (*kgsl_get_info)(VkPhysicalDevice _pdevice,
+                          VkDeviceMemory _memory,
+                          int *fd,
+                          uint32_t *offset);
+
 #define WSI_CB(cb) PFN_vk##cb cb
    WSI_CB(AllocateMemory);
    WSI_CB(AllocateCommandBuffers);
diff --git a/src/vulkan/wsi/wsi_common_drm.c b/src/vulkan/wsi/wsi_common_drm.c
index b53d485ef3a..da6afac2376 100644
--- a/src/vulkan/wsi/wsi_common_drm.c
+++ b/src/vulkan/wsi/wsi_common_drm.c
@@ -39,6 +39,10 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <xf86drm.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <linux/dma-heap.h>
 
 static VkResult
 wsi_dma_buf_export_sync_file(int dma_buf_fd, int *sync_file_fd)
@@ -54,7 +58,7 @@ wsi_dma_buf_export_sync_file(int dma_buf_fd, int *sync_file_fd)
    };
    int ret = drmIoctl(dma_buf_fd, DMA_BUF_IOCTL_EXPORT_SYNC_FILE, &export);
    if (ret) {
-      if (errno == ENOTTY || errno == EBADF || errno == ENOSYS) {
+      if (errno == ENOTTY || errno == EBADF || errno == ENOSYS || errno == ENODEV) {
          no_dma_buf_sync_file = true;
          return VK_ERROR_FEATURE_NOT_PRESENT;
       } else {
@@ -82,7 +86,7 @@ wsi_dma_buf_import_sync_file(int dma_buf_fd, int sync_file_fd)
    };
    int ret = drmIoctl(dma_buf_fd, DMA_BUF_IOCTL_IMPORT_SYNC_FILE, &import);
    if (ret) {
-      if (errno == ENOTTY || errno == EBADF || errno == ENOSYS) {
+      if (errno == ENOTTY || errno == EBADF || errno == ENOSYS || errno == ENODEV) {
          no_dma_buf_sync_file = true;
          return VK_ERROR_FEATURE_NOT_PRESENT;
       } else {
@@ -306,6 +310,11 @@ wsi_create_native_image_mem(const struct wsi_swapchain *chain,
                             const struct wsi_image_info *info,
                             struct wsi_image *image);
 
+static VkResult
+wsi_create_kgsl_image_mem(const struct wsi_swapchain *chain,
+                            const struct wsi_image_info *info,
+                            struct wsi_image *image);
+
 static VkResult
 wsi_configure_native_image(const struct wsi_swapchain *chain,
                            const VkSwapchainCreateInfoKHR *pCreateInfo,
@@ -444,7 +453,10 @@ wsi_configure_native_image(const struct wsi_swapchain *chain,
       }
    }
 
-   info->create_mem = wsi_create_native_image_mem;
+   if (wsi->is_tu_kgsl)
+      info->create_mem = wsi_create_kgsl_image_mem;
+   else
+      info->create_mem = wsi_create_native_image_mem;
 
    return VK_SUCCESS;
 
@@ -563,6 +575,124 @@ wsi_create_native_image_mem(const struct wsi_swapchain *chain,
    return VK_SUCCESS;
 }
 
+static int
+dma_heap_alloc(uint64_t size)
+{
+   int fd = -1, heap = open("/dev/dma_heap/system", O_RDONLY);
+   if (heap < 0)
+      goto fail_open;
+   struct dma_heap_allocation_data alloc_data = {.len = size, .fd_flags = O_RDWR | O_CLOEXEC};
+   if (ioctl(heap, DMA_HEAP_IOCTL_ALLOC, &alloc_data) < 0)
+      goto fail_alloc;
+   fd = alloc_data.fd;
+fail_alloc:
+   close(heap);
+fail_open:
+   return fd;
+}
+
+static int ion_alloc(uint64_t size) {
+   int fd = -1, ion_dev = open("/dev/ion", O_RDONLY);
+   if (ion_dev < 0)
+      goto fail_open;
+   struct ion_allocation_data {
+      __u64 len;
+      __u32 heap_id_mask;
+      __u32 flags;
+      __u32 fd;
+      __u32 unused;
+   } alloc_data = {
+       .len = size,
+       /* ION_HEAP_SYSTEM | ION_SYSTEM_HEAP_ID */
+       .heap_id_mask = (1U << 0) | (1U << 25),
+       .flags = 0, /* uncached */
+   };
+   if (ioctl(ion_dev, _IOWR('I', 0, struct ion_allocation_data), &alloc_data) <
+       0)
+      goto fail_alloc;
+   fd = alloc_data.fd;
+fail_alloc:
+   close(ion_dev);
+fail_open:
+   return fd;
+};
+
+static VkResult
+wsi_create_kgsl_image_mem(const struct wsi_swapchain *chain,
+                            const struct wsi_image_info *info,
+                            struct wsi_image *image)
+{
+   const struct wsi_device *wsi = chain->wsi;
+   VkResult result;
+
+   VkMemoryRequirements reqs;
+   wsi->GetImageMemoryRequirements(chain->device, image->image, &reqs);
+
+   if (debug_get_bool_option("USE_HEAP", true)) {
+      image->dma_buf_fd = dma_heap_alloc(reqs.size);
+      if (image->dma_buf_fd < 0)
+         image->dma_buf_fd = ion_alloc(reqs.size);
+   }
+
+   const struct wsi_memory_allocate_info memory_wsi_info = {
+      .sType = VK_STRUCTURE_TYPE_WSI_MEMORY_ALLOCATE_INFO_MESA,
+      .pNext = NULL,
+      .implicit_sync = true,
+   };
+   const VkImportMemoryFdInfoKHR memory_import_info = {
+      .sType = VK_STRUCTURE_TYPE_IMPORT_MEMORY_FD_INFO_KHR,
+      .pNext = &memory_wsi_info,
+      .fd = os_dupfd_cloexec(image->dma_buf_fd),
+      .handleType = VK_EXTERNAL_MEMORY_HANDLE_TYPE_DMA_BUF_BIT_EXT
+   };
+   const VkMemoryDedicatedAllocateInfo memory_dedicated_info = {
+      .sType = VK_STRUCTURE_TYPE_MEMORY_DEDICATED_ALLOCATE_INFO,
+      .pNext = (image->dma_buf_fd < 0) ? (void*)&memory_wsi_info : (void*)&memory_import_info,
+      .image = image->image,
+      .buffer = VK_NULL_HANDLE,
+   };
+   const VkMemoryAllocateInfo memory_info = {
+      .sType = VK_STRUCTURE_TYPE_MEMORY_ALLOCATE_INFO,
+      .pNext = &memory_dedicated_info,
+      .allocationSize = reqs.size,
+      .memoryTypeIndex =
+         wsi_select_device_memory_type(wsi, reqs.memoryTypeBits),
+   };
+   result = wsi->AllocateMemory(chain->device, &memory_info,
+                                &chain->alloc, &image->memory);
+   if (result != VK_SUCCESS)
+      return result;
+
+   uint32_t dma_buf_offset = 0;
+   if (image->dma_buf_fd == -1)
+      wsi->kgsl_get_info(wsi->pdevice, image->memory, &image->dma_buf_fd,
+                 &dma_buf_offset);
+
+   image->cpu_map = mmap(0, reqs.size, PROT_READ | PROT_WRITE, MAP_SHARED,
+                             image->dma_buf_fd, dma_buf_offset);
+
+   if (image->cpu_map == MAP_FAILED)
+      return VK_ERROR_OUT_OF_HOST_MEMORY;
+   munmap(image->cpu_map, reqs.size);
+
+   const VkImageSubresource image_subresource = {
+      .aspectMask = VK_IMAGE_ASPECT_COLOR_BIT,
+      .mipLevel = 0,
+      .arrayLayer = 0,
+   };
+   VkSubresourceLayout image_layout;
+   wsi->GetImageSubresourceLayout(chain->device, image->image,
+                                  &image_subresource, &image_layout);
+
+   image->drm_modifier = 1274; /* termux-x11's RAW_MMAPPABLE_FD */
+   image->num_planes = 1;
+   image->sizes[0] = reqs.size;
+   image->row_pitches[0] = image_layout.rowPitch;
+   image->offsets[0] = dma_buf_offset;
+
+   return VK_SUCCESS;
+}
+
 #define WSI_PRIME_LINEAR_STRIDE_ALIGN 256
 
 static VkResult
diff --git a/src/vulkan/wsi/wsi_common_x11.c b/src/vulkan/wsi/wsi_common_x11.c
index 2dff27afa64..1ba21660bab 100644
--- a/src/vulkan/wsi/wsi_common_x11.c
+++ b/src/vulkan/wsi/wsi_common_x11.c
@@ -1617,7 +1617,7 @@ x11_present_to_x11_dri3(struct x11_swapchain *chain, uint32_t image_index,
       options |= XCB_PRESENT_OPTION_SUBOPTIMAL;
 #endif
 
-   xshmfence_reset(image->shm_fence);
+   xcb_sync_reset_fence(chain->conn, image->sync_fence);
 
    ++chain->sent_image_count;
    assert(chain->sent_image_count <= chain->base.image_count);
@@ -1749,7 +1749,7 @@ x11_acquire_next_image(struct wsi_swapchain *anv_chain,
    assert(*image_index < chain->base.image_count);
    if (chain->images[*image_index].shm_fence &&
        !chain->base.image_info.explicit_sync)
-      xshmfence_await(chain->images[*image_index].shm_fence);
+      xcb_sync_await_fence(chain->conn, 1, &chain->images[*image_index].sync_fence);

    return result;
 }
@@ -2185,14 +2185,23 @@ x11_image_init(VkDevice device_h, struct x11_swapchain *chain,
          return VK_ERROR_OUT_OF_HOST_MEMORY;
 
       cookie =
-         xcb_dri3_pixmap_from_buffer_checked(chain->conn,
-                                             image->pixmap,
-                                             chain->window,
-                                             image->base.sizes[0],
-                                             pCreateInfo->imageExtent.width,
-                                             pCreateInfo->imageExtent.height,
-                                             image->base.row_pitches[0],
-                                             chain->depth, bpp, fd);
+         xcb_dri3_pixmap_from_buffers_checked(chain->conn,
+                                              image->pixmap,
+                                              chain->window,
+                                              1,
+                                              pCreateInfo->imageExtent.width,
+                                              pCreateInfo->imageExtent.height,
+                                              image->base.row_pitches[0],
+                                              image->base.offsets[0],
+                                              0,
+                                              0,
+                                              0,
+                                              0,
+                                              0,
+                                              0,
+                                              chain->depth, bpp,
+                                              image->base.drm_modifier,
+                                              &fd);
    }
 
    error = xcb_request_check(chain->conn, cookie);
@@ -2201,6 +2210,11 @@ x11_image_init(VkDevice device_h, struct x11_swapchain *chain,
       goto fail_image;
    }
 
+   image->sync_fence = xcb_generate_id(chain->conn);
+   xcb_sync_create_fence(chain->conn, image->pixmap, image->sync_fence, false);
+   xcb_sync_trigger_fence(chain->conn, image->sync_fence);
+   return VK_SUCCESS;
+
 out_fence:
    fence_fd = xshmfence_alloc_shm();
    if (fence_fd < 0)
@@ -2245,7 +2260,6 @@ x11_image_finish(struct x11_swapchain *chain,
    if (!chain->base.wsi->sw || chain->has_mit_shm) {
       cookie = xcb_sync_destroy_fence(chain->conn, image->sync_fence);
       xcb_discard_reply(chain->conn, cookie.sequence);
-      xshmfence_unmap_shm(image->shm_fence);
 
       cookie = xcb_free_pixmap(chain->conn, image->pixmap);
       xcb_discard_reply(chain->conn, cookie.sequence);
