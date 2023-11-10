TERMUX_PKG_HOMEPAGE=https://github.com/termux-pacman/glibc-packages
TERMUX_PKG_DESCRIPTION="Give fake functions 'linkat' and 'link'"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.0
TERMUX_PKG_DEPENDS="bash-glibc"
TERMUX_PKG_SKIP_SRC_EXTRACT=true

termux_step_make() {
	local path_lib=$TERMUX_PREFIX/lib/libfakeroot/fakehardlink
	mkdir -p $path_lib
	$CC ${TERMUX_PKG_BUILDER_DIR}/fakehardlink.c -o ${path_lib}/libfakehardlink.so -fPIC -shared -ldl
	ln -sf libfakeroot/fakehardlink/libfakehardlink.so $TERMUX_PREFIX/lib

	install -m755 ${TERMUX_PKG_BUILDER_DIR}/fakehardlink ${TERMUX_PREFIX}/bin
	sed -i "s|@TERMUX_PREFIX@|$TERMUX_PREFIX|g; s|@TERMUX_PKG_VERSION@|$TERMUX_PKG_VERSION|g" ${TERMUX_PREFIX}/bin/fakehardlink
}
