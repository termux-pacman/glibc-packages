TERMUX_PKG_HOMEPAGE=https://dri.freedesktop.org/wiki/
TERMUX_PKG_DESCRIPTION="Userspace interface to kernel DRM services"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="2.4.120"
TERMUX_PKG_SRCURL=https://dri.freedesktop.org/libdrm/libdrm-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=3bf55363f76c7250946441ab51d3a6cc0ae518055c0ff017324ab76cdefb327a
TERMUX_PKG_DEPENDS="libpciaccess-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Dudev=false
-Dvalgrind=disabled
-Dinstall-test-programs=true
"

termux_step_pre_configure() {
	if [ "$TERMUX_ARCH" = "arm" ]; then
		TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" -Domap=enabled -Dexynos=enabled -Dtegra=enabled -Detnaviv=enabled"
	fi
}

termux_step_install_license() {
	install -Dm600 -t $TERMUX_PREFIX/share/doc/$TERMUX_PKG_NAME \
		$TERMUX_PKG_BUILDER_DIR/LICENSE
}
