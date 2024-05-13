TERMUX_PKG_HOMEPAGE=https://www.cl.cam.ac.uk/~mgk25/jbigkit/
TERMUX_PKG_DESCRIPTION="Data compression library/utilities for bi-level high-resolution images"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="2.1"
TERMUX_PKG_SRCURL=https://www.cl.cam.ac.uk/~mgk25/download/jbigkit-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=de7106b6bfaf495d6865c7dd7ac6ca1381bd12e0d81405ea81e7f2167263d932
TERMUX_PKG_DEPENDS="glibc"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make() {
	make EXTRA_CFLAGS="$CFLAGS"
}

termux_step_make_install() {
	install -vDm 644 libjbig/*.h -t $TERMUX_PREFIX/include/
	install -vDm 755 libjbig/*.so.* -t $TERMUX_PREFIX/lib/
	for lib in libjbig.so libjbig85.so; do
		ln -svf "$lib.${TERMUX_PKG_VERSION}" $TERMUX_PREFIX/lib/$lib
	done
	install -vDm 755 pbmtools/{jbgtopbm{,85},pbmtojbg{,85}} -t $TERMUX_PREFIX/bin/
	install -vDm 644 pbmtools/*.1* -t $TERMUX_PREFIX/share/man/man1/
}
