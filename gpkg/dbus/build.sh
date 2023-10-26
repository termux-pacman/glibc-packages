TERMUX_PKG_HOMEPAGE=https://dbus.freedesktop.org
TERMUX_PKG_DESCRIPTION="Freedesktop.org message bus system"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.15.6
TERMUX_PKG_SRCURL="https://dbus.freedesktop.org/releases/dbus/dbus-$TERMUX_PKG_VERSION.tar.xz"
TERMUX_PKG_SHA256=f97f5845f9c4a5a1fb3df67dfa9e16b5a3fd545d348d6dc850cb7ccc9942bd8c
TERMUX_PKG_DEPENDS="libexpat-glibc, libx11-glibc"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-libaudit
--disable-systemd
--disable-tests
--disable-xml-docs
--enable-inotify
--enable-x11-autolaunch
--with-test-socket-dir=$TERMUX_PREFIX_CLASSICAL/tmp
--with-session-socket-dir=$TERMUX_PREFIX_CLASSICAL/tmp
--with-x=auto
"

termux_step_create_debscripts() {
	{
		echo "#!${TERMUX_PREFIX}/bin/sh"
		echo "if [ ! -e ${TERMUX_PREFIX}/var/lib/dbus/machine-id ]; then"
		echo "mkdir -p ${TERMUX_PREFIX}/var/lib/dbus"
		echo "dbus-uuidgen > ${TERMUX_PREFIX}/var/lib/dbus/machine-id"
		echo "fi"
		echo "exit 0"
	} > postinst
}
