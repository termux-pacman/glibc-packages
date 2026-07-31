TERMUX_PKG_HOMEPAGE=https://dri.freedesktop.org/wiki/
TERMUX_PKG_DESCRIPTION="Userspace interface to kernel DRM services"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="2.4.134"
TERMUX_PKG_SRCURL=https://dri.freedesktop.org/libdrm/libdrm-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=ac5e74d157830eb8bee44c6a6bf3ad49774ef0dd2a72bdad74a8f20308b52a95
TERMUX_PKG_DEPENDS="libpciaccess-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Dudev=false
-Dvalgrind=disabled
-Dinstall-test-programs=true
"

termux_step_pre_configure() {
	#sed -i "s|\"/dev/|\"${TERMUX_PREFIX}/dev/|g" $(grep -s -r -l '"/dev/')
	if [ "$TERMUX_ARCH" = "aarch64" ] || [ "$TERMUX_ARCH" = "arm" ]; then
		TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" -Domap=enabled -Dexynos=enabled -Dtegra=enabled -Detnaviv=enabled -Dfreedreno-kgsl=true"
	fi
}

termux_step_install_license() {
	install -Dm600 -t $TERMUX_PREFIX/share/doc/$TERMUX_PKG_NAME \
		$TERMUX_PKG_BUILDER_DIR/LICENSE
}
