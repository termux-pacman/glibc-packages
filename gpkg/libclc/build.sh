TERMUX_PKG_HOMEPAGE=https://libclc.llvm.org/
TERMUX_PKG_DESCRIPTION="Library requirements of the OpenCL C programming language"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=18.1.5
TERMUX_PKG_SRCURL=https://github.com/llvm/llvm-project/releases/download/llvmorg-$TERMUX_PKG_VERSION/libclc-$TERMUX_PKG_VERSION.src.tar.xz
TERMUX_PKG_SHA256=3e54662d1897b1af5ec6d9cd04831393cab428d1a93814ad3812255ae2aa0d45
TERMUX_PKG_BUILD_DEPENDS="clang-glibc, python-glibc, spirv-llvm-translator-glibc"
TERMUX_PKG_PLATFORM_INDEPENDENT=true

termux_step_configure() {
	termux_setup_ninja

	local OLD_PATH="${PATH}"
	export PATH="${TERMUX_PREFIX}/bin:${PATH}"

	termux_setup_cmake
	cmake ${TERMUX_PKG_SRCDIR} \
		-G Ninja \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX=$TERMUX_PREFIX

	export PATH=$OLD_PATH
}

termux_step_make() {
	local OLD_PATH="${PATH}"
	export PATH="${TERMUX_PREFIX}/bin:${PATH}"

	ninja

	export PATH=$OLD_PATH
}
