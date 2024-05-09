TERMUX_PKG_HOMEPAGE=https://www.postgresql.org
TERMUX_PKG_DESCRIPTION="Object-relational SQL database"
TERMUX_PKG_LICENSE="PostgreSQL"
TERMUX_PKG_LICENSE_FILE="COPYRIGHT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="16.3"
TERMUX_PKG_SRCURL=https://ftp.postgresql.org/pub/source/v$TERMUX_PKG_VERSION/postgresql-$TERMUX_PKG_VERSION.tar.bz2
TERMUX_PKG_SHA256=331963d5d3dc4caf4216a049fa40b66d6bcb8c730615859411b9518764e60585
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
		(make -C contrib/${contrib} -s -j ${TERMUX_MAKE_PROCESSES} install)
	done
}
