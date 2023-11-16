TERMUX_PKG_HOMEPAGE=https://cairographics.org
TERMUX_PKG_DESCRIPTION="Cairo 2D vector graphics library"
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.18.0
TERMUX_PKG_SRCURL=https://gitlab.freedesktop.org/cairo/cairo/-/archive/${TERMUX_PKG_VERSION}/cairo-${TERMUX_PKG_VERSION}.tar.bz2
TERMUX_PKG_SHA256=abf8fba4d510086a492783c3e0828e90b32734738fd80906595617d229d02bab
TERMUX_PKG_DEPENDS="fontconfig-glibc, glib-glibc, libpng-glibc, libx11-glibc, libxcb-glibc, libxext-glibc, libxrender-glibc, liblzo-glibc, libpixman-glibc, zlib-glibc"
TERMUX_PKG_MESON_NATIVE=true
#-Dgtk_doc=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Ddwrite=disabled
-Dspectre=disabled
-Dsymbol-lookup=disabled
-Dtests=disabled
"
