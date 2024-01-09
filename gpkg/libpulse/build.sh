TERMUX_PKG_HOMEPAGE="https://www.freedesktop.org/wiki/Software/PulseAudio"
TERMUX_PKG_DESCRIPTION="PulseAudio client libraries"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_SRCURL="git+https://github.com/pulseaudio/pulseaudio"
TERMUX_PKG_VERSION="16.99.1"
TERMUX_PKG_REVISION=1
TERMUX_PKG_DEPENDS="libsndfile-glibc, libltdl-glibc, gdbm-glibc, libxcb-glibc, libxtst-glibc, libsm-glibc, libtool-glibc, libcap-glibc, dbus-glibc"
TERMUX_PKG_BUILD_DEPENDS="gettext-glibc"
TERMUX_PKG_CONFFILES="glibc/etc/pulse/client.conf, glibc/etc/pulse/daemon.conf, glibc/etc/pulse/default.pa, glibc/etc/pulse/system.pa"

# manpages generation requires perl's XML::Parser.
# pulseaudio daemon is useless on glibc,
# because it cannot use system sound libraries.
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Dman=false
-Dtests=false
-Ddatabase=gdbm
-Dx11=enabled
"

# Maxython: I need to learn how the audio driver works in Android in order to configure glibc

termux_step_pre_configure() {
	LDFLAGS+=" -lm"
}
