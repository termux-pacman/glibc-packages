TERMUX_PKG_HOMEPAGE=https://gitlab.gnome.org/World/libcloudproviders
TERMUX_PKG_DESCRIPTION="DBus API that allows cloud storage sync clients to expose their services"
TERMUX_PKG_LICENSE="LGPL-3.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=0.3.6
TERMUX_PKG_SRCURL=https://gitlab.gnome.org/World/libcloudproviders/-/archive/${TERMUX_PKG_VERSION}/libcloudproviders-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=fa25bdc2e415a717999f3d0bac8756dc0dcfe40e3ada864fadc26df0746a7116
TERMUX_PKG_DEPENDS="glib-glibc, dbus-glibc"
TERMUX_PKG_BUILD_DEPENDS="gobject-introspection-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="-Dvapigen=false"
