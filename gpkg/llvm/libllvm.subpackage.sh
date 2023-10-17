TERMUX_SUBPKG_INCLUDE="
glibc/lib/libLLVM*.so*
glibc/lib/libLTO*.so*
glibc/lib/libRemarks*.so*
glibc/lib/LLVMgold.so
glibc/lib/bfd-plugins
"
TERMUX_SUBPKG_DEPEND_ON_PARENT="no"
TERMUX_SUBPKG_DEPENDS="gcc-libs-glibc, zlib-glibc, zstd-glibc, libffi-glibc, libedit-glibc, ncurses-glibc, libxml2-glibc"
TERMUX_SUBPKG_DESCRIPTION="LLVM runtime libraries"
