TERMUX_PKG_HOMEPAGE=https://github.com/flightlessmango/MangoHud/
TERMUX_PKG_DESCRIPTION="A Vulkan overlay layer for monitoring FPS, temperatures, CPU/GPU load and more"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="0.7.2"
TERMUX_PKG_SRCURL=https://github.com/flightlessmango/MangoHud/releases/download/v${TERMUX_PKG_VERSION}/MangoHud-v${TERMUX_PKG_VERSION}-Source.tar.xz
TERMUX_PKG_SHA256=114ad3ea87b1db7358816c7b8e7843aaee356ff048b9e15d6fff02d89414841b
TERMUX_PKG_DEPENDS="dbus-glibc, libx11-glibc, python-pip-glibc, vulkan-icd-loader-glibc, libxkbcommon-glibc"
TERMUX_PKG_BUILD_DEPENDS="nlohmann-json-glibc, glslang-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Ddynamic_string_tokens=false
-Dwith_xnvctrl=disabled
"

termux_step_create_debscripts() {
	echo "#!$TERMUX_PREFIX_CLASSICAL/bin/bash" > postinst
	echo "LD_PRELOAD='' $TERMUX_PREFIX/bin/pip install --upgrade matplotlib numpy" >> postinst
	if [ "$TERMUX_PACKAGE_FORMAT" = "pacman" ]; then
		echo "post_install" > postupg
	fi
}
