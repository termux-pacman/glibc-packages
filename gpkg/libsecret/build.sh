TERMUX_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/libsecret
TERMUX_PKG_DESCRIPTION="A GObject-based library for accessing the Secret Service API"
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="0.21.4"
TERMUX_PKG_SRCURL=https://download.gnome.org/sources/libsecret/${TERMUX_PKG_VERSION%.*}/libsecret-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=163d08d783be6d4ab9a979ceb5a4fecbc1d9660d3c34168c581301cd53912b20
TERMUX_PKG_DEPENDS="glib-glibc, libgcrypt-glibc, tpm2-tss-glibc"
TERMUX_PKG_BUILD_DEPENDS="gobject-introspection-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Dgtk_doc=false
-Dvapi=false
-Dtpm2=true
"
