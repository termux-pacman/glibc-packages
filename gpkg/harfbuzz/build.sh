TERMUX_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/HarfBuzz/
TERMUX_PKG_DESCRIPTION="OpenType text shaping engine"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=8.4.0
TERMUX_PKG_REVISION=3
TERMUX_PKG_SRCURL=https://github.com/harfbuzz/harfbuzz/archive/${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=9f1ca089813b05944ad1ce8c7e018213026d35dc9bab480a21eb876838396556
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
