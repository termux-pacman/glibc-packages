TERMUX_PKG_HOMEPAGE=https://xkbcommon.org/
TERMUX_PKG_DESCRIPTION="Keymap handling library for toolkits and window systems"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="1.7.0"
TERMUX_PKG_SRCURL=https://github.com/xkbcommon/libxkbcommon/archive/xkbcommon-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=20d5e40dabd927f7a7f4342bebb1e8c7a59241283c978b800ae3bf60394eabc4
TERMUX_PKG_DEPENDS="xkeyboard-config-glibc, libxcb-glibc, libwayland-glibc"
TERMUX_PKG_BUILD_DEPENDS="libwayland-protocols-glibc, bash-completion-glibc, doxygen-glibc"

termux_step_configure() {
	termux_step_configure_meson
}
