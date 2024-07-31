TERMUX_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/fontconfig/
TERMUX_PKG_DESCRIPTION="Library for configuring and customizing font access"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=2.15.0
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://gitlab.freedesktop.org/fontconfig/fontconfig/-/archive/${TERMUX_PKG_VERSION}/fontconfig-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=cdebb4b805d33e9bdefcc0ef9743db638d2acb21139bbe1a6a85878d4c3e8c9e
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
