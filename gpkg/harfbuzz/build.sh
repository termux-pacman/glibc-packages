TERMUX_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/HarfBuzz/
TERMUX_PKG_DESCRIPTION="OpenType text shaping engine"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=9.0.0
TERMUX_PKG_SRCURL=https://github.com/harfbuzz/harfbuzz/archive/${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=b7e481b109d19aefdba31e9f5888aa0cdfbe7608fed9a43494c060ce1f8a34d2
TERMUX_PKG_DEPENDS="freetype-glibc, glib-glibc, libcairo-glibc, libgraphite-glibc, libicu-glibc"
TERMUX_PKG_BUILD_DEPENDS="gobject-introspection-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Ddocs=disabled
-Dgraphite2=enabled
-Dintrospection=enabled
"

termux_step_pre_configure() {
	CFLAGS="${CFLAGS/-fexceptions/}"
	CXXFLAGS="${CXXFLAGS/-fexceptions/}"
}

termux_step_configure() {
	termux_step_configure_meson
}
