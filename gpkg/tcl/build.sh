TERMUX_PKG_HOMEPAGE=https://www.tcl.tk/
TERMUX_PKG_DESCRIPTION="Powerful but easy to learn dynamic programming language"
TERMUX_PKG_LICENSE="custom"
TERMUX_PKG_LICENSE_FILE="../license.terms"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=8.6.13
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://downloads.sourceforge.net/project/tcl/Tcl/${TERMUX_PKG_VERSION}/tcl${TERMUX_PKG_VERSION}-src.tar.gz
TERMUX_PKG_SHA256=43a1fae7412f61ff11de2cfd05d28cfc3a73762f354a417c62370a54e2caf066
TERMUX_PKG_DEPENDS="zlib-glibc, gcc-libs-glibc"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_NO_STATICSPLIT=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--mandir=$TERMUX_PREFIX/share/man
--enable-man-symlinks
--enable-threads
--enable-64bit
"

termux_step_pre_configure() {
	rm -rf $TERMUX_PKG_SRCDIR/pkgs/sqlite3* # libsqlite-tcl is a separate package
	TERMUX_PKG_SRCDIR=$TERMUX_PKG_SRCDIR/unix
}

termux_step_post_make_install() {
	# expect needs private headers
	make install-private-headers

	ln -sf tclsh${TERMUX_PKG_VERSION%.*} $TERMUX_PREFIX/bin/tclsh
	ln -sf libtcl${TERMUX_PKG_VERSION%.*}.so $TERMUX_PREFIX/lib/libtcl.so
	install -Dm644 $TERMUX_PKG_SRCDIR/tcl.m4 -t $TERMUX_PREFIX/share/aclocal
	chmod 644 $TERMUX_PREFIX/lib/libtclstub8.6.a

	# remove buildroot traces
	local _tclver=8.6
	sed -e "s#$TERMUX_PKG_BUILDDIR#$TERMUX_PREFIX/lib#" \
		-e "s#$TERMUX_PKG_BUILDDIR#$TERMUX_PREFIX/include#" \
		-e "s#'{$TERMUX_PREFIX/lib} '#'$TERMUX_PREFIX/lib/tcl$_tclver'#" \
		-i $TERMUX_PREFIX/lib/tclConfig.sh

	local tdbcver=tdbc1.1.5
	sed -e "s#$TERMUX_PKG_BUILDDIR/pkgs/$tdbcver#$TERMUX_PREFIX/lib/$tdbcver#" \
		-e "s#$TERMUX_PKG_BUILDDIR/pkgs/$tdbcver/generic#$TERMUX_PREFIX/include#" \
		-e "s#$TERMUX_PKG_BUILDDIR/pkgs/$tdbcver/library#$TERMUX_PREFIX/lib/tcl${TERMUX_PKG_VERSION%.*}#" \
		-e "s#$TERMUX_PKG_BUILDDIR/pkgs/$tdbcver#$TERMUX_PREFIX/include#" \
		-i $TERMUX_PREFIX/lib/$tdbcver/tdbcConfig.sh

	local itclver=itcl4.2.3
	sed -e "s#$TERMUX_PKG_BUILDDIR/pkgs/$itclver#$TERMUX_PREFIX/lib/$itclver#" \
		-e "s#$TERMUX_PKG_BUILDDIR/pkgs/$itclver/generic#$TERMUX_PREFIX/include#" \
		-e "s#$TERMUX_PKG_BUILDDIR/pkgs/$itclver#$TERMUX_PREFIX/include#" \
		-i $TERMUX_PREFIX/lib/$itclver/itclConfig.sh
}
