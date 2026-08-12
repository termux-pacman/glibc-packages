TERMUX_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/fontconfig/
TERMUX_PKG_DESCRIPTION="Library for configuring and customizing font access"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=2.18.3
TERMUX_PKG_SRCURL=https://gitlab.freedesktop.org/fontconfig/fontconfig/-/archive/${TERMUX_PKG_VERSION}/fontconfig-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=9ae01e1d53acdef56010c5451cd34aa41d325b2faccd8606448d8fa01b2496b3
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
