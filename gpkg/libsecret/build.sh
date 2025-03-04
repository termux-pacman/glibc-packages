TERMUX_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/libsecret
TERMUX_PKG_DESCRIPTION="A GObject-based library for accessing the Secret Service API"
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="0.21.6"
TERMUX_PKG_SRCURL=https://download.gnome.org/sources/libsecret/${TERMUX_PKG_VERSION%.*}/libsecret-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=747b8c175be108c880d3adfb9c3537ea66e520e4ad2dccf5dce58003aeeca090
TERMUX_PKG_DEPENDS="glib-glibc, libgcrypt-glibc, tpm2-tss-glibc"
TERMUX_PKG_BUILD_DEPENDS="gobject-introspection-glibc, docbook-xsl-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Dgtk_doc=false
-Dvapi=false
-Dtpm2=true
"
