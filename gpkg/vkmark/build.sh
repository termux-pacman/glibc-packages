TERMUX_PKG_HOMEPAGE=https://github.com/vkmark/vkmark
TERMUX_PKG_DESCRIPTION="vkmark is an extensible Vulkan benchmarking suite with targeted, configurable scenes."
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_MAINTAINER="@termux-pacman"
_COMMIT=ab6e6f34077722d5ae33f6bd40b18ef9c0e99a15
TERMUX_PKG_VERSION=2023.04.12
TERMUX_PKG_SRCURL=git+https://github.com/vkmark/vkmark.git
TERMUX_PKG_SHA256=2fde566a542fddc5c74a62c40dcb2d62e1151c7fbdc395adb1dc21857defa09d
TERMUX_PKG_GIT_BRANCH=master
TERMUX_PKG_DEPENDS="vulkan-icd-loader-glibc, gcc-libs-glibc, assimp-glibc, xcb-util-wm-glibc, libwayland-glibc"
TERMUX_PKG_BUILD_DEPENDS="vulkan-headers-glibc, xorgproto-glibc, libwayland-protocols-glibc, glm-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="-Dkms=false"

termux_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$TERMUX_PKG_VERSION" ]; then
		echo -n "ERROR: The specified version \"$TERMUX_PKG_VERSION\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi

	local s=($(find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | LC_ALL=C sort | sha256sum))
	if [[ ${s[0]} != $TERMUX_PKG_SHA256 ]]; then
		echo "Expected: $TERMUX_PKG_SHA256"
		echo "Got: ${s[0]}"
		termux_error_exit "Checksum mismatch for source files."
	fi
}
