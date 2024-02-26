TERMUX_PKG_HOMEPAGE="https://github.com/termux-pacman/glibc-packages/wiki/About-glibc-runner-(grun)"
TERMUX_PKG_DESCRIPTION="Tool for convenient use of Glibc"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=2.0
TERMUX_PKG_REVISION=3
TERMUX_PKG_DEPENDS="glibc, termux-exec-glibc, bash-glibc, bash, patchelf-glibc, binutils-glibc, strace-glibc"
TERMUX_PKG_RECOMMENDS="coreutils-glibc, util-linux-glibc"
TERMUX_PKG_CONFFILES="etc/glibc-runner.bashrc"
TERMUX_PKG_SKIP_SRC_EXTRACT=true
TERMUX_PKG_PLATFORM_INDEPENDENT=true
TERMUX_PKG_ESSENTIAL=true

termux_step_make_install() {
	mkdir -p ${TERMUX_PREFIX_CLASSICAL}/opt/glibc-runner
	install -m644 ${TERMUX_PKG_BUILDER_DIR}/glibc-runner.sh ${TERMUX_PREFIX_CLASSICAL}/opt/glibc-runner
	install -m644 ${TERMUX_PKG_BUILDER_DIR}/glibc-runner.bashrc ${TERMUX_PREFIX_CLASSICAL}/etc
	ln -sf ${TERMUX_PREFIX_CLASSICAL}/etc/glibc-runner.bashrc ${TERMUX_PREFIX}/etc/glibc-runner.bashrc

	sed -i "s|@TERMUX_PREFIX_CLASSICAL@|$TERMUX_PREFIX_CLASSICAL|g; s|@TERMUX_PKG_VERSION@|$TERMUX_PKG_VERSION|g" \
		${TERMUX_PREFIX_CLASSICAL}/opt/glibc-runner/glibc-runner.sh

	sed -i "s|@TERMUX_PREFIX_CLASSICAL@|$TERMUX_PREFIX_CLASSICAL|g" \
		${TERMUX_PREFIX_CLASSICAL}/etc/glibc-runner.bashrc

	local _PATH_PREFIX=""
	for _PATH_PREFIX in ${TERMUX_PREFIX_CLASSICAL} ${TERMUX_PREFIX}; do
		install -m755 ${TERMUX_PKG_BUILDER_DIR}/glibc-runner ${_PATH_PREFIX}/bin
		sed -i "s|@SHELL_PATH@|${_PATH_PREFIX}/bin/bash|g; s|@TERMUX_PREFIX_CLASSICAL@|${TERMUX_PREFIX_CLASSICAL}|g" \
			${_PATH_PREFIX}/bin/glibc-runner
		ln -sf ${_PATH_PREFIX}/bin/glibc-runner ${_PATH_PREFIX}/bin/grun
	done
}
