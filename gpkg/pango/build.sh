TERMUX_PKG_HOMEPAGE=https://www.pango.org/
TERMUX_PKG_DESCRIPTION="Library for laying out and rendering text"
TERMUX_PKG_LICENSE="LGPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.51.2
TERMUX_PKG_SRCURL=https://gitlab.gnome.org/GNOME/pango/-/archive/${TERMUX_PKG_VERSION}/pango-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=82b4c5232e448865865e595008b6aef2481032c898d8bbfc60fd36b680585d75
TERMUX_PKG_DEPENDS="libcairo-glibc, fribidi-glibc, harfbuzz-glibc, libthai-glibc, libxft-glibc"
TERMUX_PKG_BUILD_DEPENDS="gobject-introspection-glibc"

termux_step_pre_configure() {
	LDFLAGS+=" -lm"
}
