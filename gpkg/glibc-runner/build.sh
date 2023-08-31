TERMUX_PKG_HOMEPAGE="https://github.com/termux-pacman/glibc-packages/wiki/About-glibc-runner-(grun)"
TERMUX_PKG_DESCRIPTION="Tool for convenient use of Glibc"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.3
TERMUX_PKG_DEPENDS="glibc, bash, patchelf"
TERMUX_PKG_SKIP_SRC_EXTRACT=true
TERMUX_PKG_PLATFORM_INDEPENDENT=true
TERMUX_PKG_ESSENTIAL=true

termux_step_make_install() {
	install -m755 ${TERMUX_PKG_BUILDER_DIR}/glibc-runner ${TERMUX_PREFIX_CLASSICAL}/bin
	sed -i "s|@TERMUX_PREFIX@|$TERMUX_PREFIX|g; s|@TERMUX_PREFIX_CLASSICAL@|$TERMUX_PREFIX_CLASSICAL|g; s|@TERMUX_PKG_VERSION@|$TERMUX_PKG_VERSION|g" \
		${TERMUX_PREFIX_CLASSICAL}/bin/glibc-runner
	ln -sf ${TERMUX_PREFIX_CLASSICAL}/bin/glibc-runner ${TERMUX_PREFIX_CLASSICAL}/bin/grun
}
