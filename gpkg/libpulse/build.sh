TERMUX_PKG_HOMEPAGE="https://www.freedesktop.org/wiki/Software/PulseAudio"
TERMUX_PKG_DESCRIPTION="PulseAudio client libraries"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_SRCURL="git+https://github.com/pulseaudio/pulseaudio"
TERMUX_PKG_VERSION="17.0"
TERMUX_PKG_REVISION=1
# The old variables will be used again when the daemon is configured in pulseaudio-glibs
#TERMUX_PKG_DEPENDS="libsndfile-glibc, libltdl-glibc, gdbm-glibc, libxcb-glibc, libxtst-glibc, libsm-glibc, libtool-glibc, libcap-glibc, dbus-glibc"
TERMUX_PKG_DEPENDS="libsndfile-glibc, dbus-glibc, pulseaudio"
TERMUX_PKG_BUILD_DEPENDS="gettext-glibc"
#TERMUX_PKG_CONFFILES="glibc/etc/pulse/client.conf, glibc/etc/pulse/daemon.conf, glibc/etc/pulse/default.pa, glibc/etc/pulse/system.pa"
TERMUX_PKG_CONFFILES="glibc/etc/pulse/client.conf"

# TODO: learn android audio system

# manpages generation requires perl's XML::Parser.
# pulseaudio daemon is useless on glibc,
# because it cannot use system sound libraries.
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Ddaemon=false
-Dman=false
-Dtests=false
-Ddatabase=gdbm
-Dx11=enabled
"

termux_step_post_make_install() {
	install -m755 ${TERMUX_PKG_BUILDER_DIR}/pulseaudio-start.sh ${TERMUX_PREFIX}/bin/pulseaudio-start
	sed -i -e "s|@TERMUX_PREFIX_CLASSICAL@|$TERMUX_PREFIX_CLASSICAL|g" \
		-e "s|@TERMUX_PREFIX@|$TERMUX_PREFIX|g" \
		${TERMUX_PREFIX}/bin/pulseaudio-start
}

termux_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$TERMUX_PREFIX_CLASSICAL/bin/sh
	echo
	echo "== Warning =="
	echo "pulseaudio-glibc does not support deamon,"
	echo "it works with pulseaudio based on bionic."
	echo
	EOF

	if [ "$TERMUX_PACKAGE_FORMAT" = "pacman" ]; then
		echo "post_install" > postupg
	fi
}
