TERMUX_PKG_HOMEPAGE=https://gitlab.gnome.org/World/libcloudproviders
TERMUX_PKG_DESCRIPTION="DBus API that allows cloud storage sync clients to expose their services"
TERMUX_PKG_LICENSE="LGPL-3.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=0.4.0
TERMUX_PKG_SRCURL=https://gitlab.gnome.org/World/libcloudproviders/-/archive/${TERMUX_PKG_VERSION}/libcloudproviders-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=ff65b1d4ed685f5f1659370e7dc503e891fdc0c9174661b1447e04798b98ed83
TERMUX_PKG_DEPENDS="glib-glibc, dbus-glibc"
TERMUX_PKG_BUILD_DEPENDS="gobject-introspection-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="-Dvapigen=false"
