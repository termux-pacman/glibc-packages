TERMUX_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/fontconfig/
TERMUX_PKG_DESCRIPTION="Library for configuring and customizing font access"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=2.14.2
TERMUX_PKG_SRCURL=https://www.freedesktop.org/software/fontconfig/release/fontconfig-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=dba695b57bce15023d2ceedef82062c2b925e51f5d4cc4aef736cf13f60a468b
TERMUX_PKG_DEPENDS="freetype-glibc, libexpat-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Ddefault-hinting=slight
-Ddefault-sub-pixel-rendering=rgb
-Ddoc-html=disabled
-Ddoc-pdf=disabled
-Ddoc-txt=disabled
"

termux_step_configure() {
	termux_step_configure_meson
}
