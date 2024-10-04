TERMUX_PKG_HOMEPAGE=https://www.postgresql.org
TERMUX_PKG_DESCRIPTION="Object-relational SQL database"
TERMUX_PKG_LICENSE="PostgreSQL"
TERMUX_PKG_LICENSE_FILE="COPYRIGHT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="17.0"
TERMUX_PKG_SRCURL=https://ftp.postgresql.org/pub/source/v$TERMUX_PKG_VERSION/postgresql-$TERMUX_PKG_VERSION.tar.bz2
TERMUX_PKG_SHA256=7e276131c0fdd6b62588dbad9b3bb24b8c3498d5009328dba59af16e819109de
TERMUX_PKG_DEPENDS="krb5-glibc, openssl-glibc, readline-glibc, zlib-glibc, libxml2-glibc, libpam-glibc, libicu-glibc, libllvm-glibc, libxslt-glibc, liblz4-glibc, zstd-glibc"
TERMUX_PKG_BUILD_DEPENDS="perl-glibc, python-glibc, clang-glibc"
#--with-ldap
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--with-gssapi
--with-libxml
--with-openssl
--with-perl
--with-python
--with-tcl
--with-pam
--with-readline
--with-uuid=e2fs
--with-icu
--with-llvm
--with-libxslt
--with-lz4
--with-zstd
--enable-nls
--enable-thread-safety
--disable-rpath
TCLSH=$TERMUX_PREFIX/bin/tclsh
PYTHON=$TERMUX_PREFIX/bin/python
PERL=$TERMUX_PREFIX/bin/perl
LLVM_CONFIG=$TERMUX_PREFIX/bin/llvm-config
CLANG=$TERMUX_PREFIX/bin/clang
"

termux_step_pre_configure() {
	CFLAGS+=" -ffat-lto-objects"
}

termux_step_post_make_install() {
	# Man pages are not installed by default:
	make -C doc/src/sgml install-man

	for contrib in \
		btree_gist \
		citext \
		dblink \
		fuzzystrmatch \
		hstore \
		pageinspect \
		pg_freespacemap \
		pg_stat_statements \
		pg_trgm \
		pgcrypto \
		pgrowlocks \
		postgres_fdw \
		tablefunc \
		unaccent \
		uuid-ossp \
		; do
		(make -C contrib/${contrib} -s -j ${TERMUX_PKG_MAKE_PROCESSES} install)
	done
}
