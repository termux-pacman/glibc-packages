TERMUX_PKG_HOMEPAGE=https://www.sqlite.org
TERMUX_PKG_DESCRIPTION="A C library that implements an SQL database engine"
TERMUX_PKG_LICENSE="Public Domain"
TERMUX_PKG_MAINTAINER="@termux-pacman"
_SQLITE_SRCVER=3490100
_SQLITE_YEAR=2025
TERMUX_PKG_VERSION=3.49.1
TERMUX_PKG_SRCURL=https://www.sqlite.org/${_SQLITE_YEAR}/sqlite-src-${_SQLITE_SRCVER}.zip
TERMUX_PKG_SHA256=4404d93cbce818b1b98ca7259d0ba9b45db76f2fdd9373e56f2d29b519f4d43b
TERMUX_PKG_DEPENDS="zlib-glibc"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_configure() {
	export CFLAGS="${CFLAGS/_FORTIFY_SOURCE=3/_FORTIFY_SOURCE=2}"
	export CXXFLAGS="${CXXFLAGS/_FORTIFY_SOURCE=3/_FORTIFY_SOURCE=2}"
	export CPPFLAGS="$CPPFLAGS \
		-DSQLITE_ENABLE_COLUMN_METADATA=1 \
		-DSQLITE_ENABLE_UNLOCK_NOTIFY \
		-DSQLITE_ENABLE_DBSTAT_VTAB=1 \
		-DSQLITE_ENABLE_FTS3_TOKENIZER=1 \
		-DSQLITE_ENABLE_FTS3_PARENTHESIS \
		-DSQLITE_SECURE_DELETE \
		-DSQLITE_ENABLE_STMTVTAB \
		-DSQLITE_MAX_VARIABLE_NUMBER=250000 \
		-DSQLITE_MAX_EXPR_DEPTH=10000 \
		-DSQLITE_ENABLE_MATH_FUNCTIONS"

	./configure \
		--prefix=$TERMUX_PREFIX \
		--disable-static \
		--enable-fts3 \
		--enable-fts4 \
		--enable-fts5 \
		--rtree \
		--soname=legacy \
		TCLLIBDIR="$TERMUX_PREFIX/lib/sqlite$TERMUX_PKG_VERSION"
}

termux_step_make() {
	make
	make showdb showjournal showstat4 showwal sqldiff sqlite3_analyzer
}

termux_step_post_make_install() {
	install -m755 showdb showjournal showstat4 showwal sqldiff sqlite3_analyzer lemon $TERMUX_PREFIX/bin/

	install -m755 -d $TERMUX_PREFIX/share/man/man1
	install -m644 $TERMUX_PKG_SRCDIR/sqlite3.1 $TERMUX_PREFIX/share/man/man1/

	install -m755 -d $TERMUX_PREFIX/share/man/mann
	install -m644 $TERMUX_PKG_SRCDIR/autoconf/tea/doc/sqlite3.n $TERMUX_PREFIX/share/man/mann/

	install -Dm644 lempar.c $TERMUX_PREFIX/share/lemon/lempar.c
}
