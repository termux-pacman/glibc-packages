TERMUX_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/fontconfig/
TERMUX_PKG_DESCRIPTION="Library for configuring and customizing font access"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=2.16.1
TERMUX_PKG_SRCURL=https://gstreamer.freedesktop.org/src/mirror/fontconfig/fontconfig-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=f4577b62f3a909597c9fb032c6a7a2ae39649ed8ce7048b615a48f32abc0d53a
TERMUX_PKG_DEPENDS="freetype-glibc, libexpat-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Ddefault-fonts-dirs=/system/fonts,$TERMUX_PREFIX/share/fonts
-Dadditional-fonts-dirs=$TERMUX_PREFIX_CLASSICAL/share/fonts
-Ddefault-hinting=slight
-Ddefault-sub-pixel-rendering=rgb
-Ddoc-html=disabled
-Ddoc-pdf=disabled
-Ddoc-txt=disabled
"

termux_step_configure() {
	termux_step_configure_meson
}
