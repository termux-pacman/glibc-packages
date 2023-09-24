TERMUX_PKG_HOMEPAGE=https://github.com/ptitSeb/box86
TERMUX_PKG_DESCRIPTION="Linux Userspace x86 Emulator with a twist"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=0.3.2
TERMUX_PKG_SRCURL=https://github.com/ptitSeb/box86/archive/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=468e887002706705bf003411fa47adb035e04e1cbeda3372405fed93f33fe8f4
TERMUX_PKG_DEPENDS="gcc-libs-glibc"
TERMUX_PKG_BLACKLISTED_ARCHES="aarch64, x86_64, i686"
TERMUX_CMAKE_BUILD="Unix Makefiles"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DARM_DYNAREC=ON
-DCMAKE_BUILD_TYPE=RelWithDebInfo
"

termux_step_make_install() {
	install -Dm755 box86 -t ${TERMUX_PREFIX}/bin/

	install -dm755 ${TERMUX_PREFIX}/etc/binfmt.d/
	install -Dm644 ${TERMUX_PKG_SRCDIR}/system/box86.box86rc ${TERMUX_PREFIX}/etc/

	install -dm755 ${TERMUX_PREFIX}/lib/i386-linux-gnu/
	for i in ${TERMUX_PKG_SRCDIR}/x86lib/*; do
		install -Dm644 ${i} ${TERMUX_PREFIX}/lib/i386-linux-gnu/
	done
}
