TERMUX_PKG_HOMEPAGE=https://mariadb.org
TERMUX_PKG_DESCRIPTION="A drop-in replacement for mysql server"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="11.4.2"
TERMUX_PKG_SRCURL=https://mirror.netcologne.de/mariadb/mariadb-${TERMUX_PKG_VERSION}/source/mariadb-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=8c600e38adb899316c1cb11c68b87979668f4fb9d858000e347e6d8b7abe51b0
TERMUX_PKG_DEPENDS="openssl-glibc, libxcrypt-glibc, pcre2-glibc, zlib-glibc, zstd-glibc, ncurses-glibc, libbz2-glibc, libxml2-glibc, liblz4-glibc, perl-glibc"
TERMUX_PKG_BUILD_DEPENDS="boost-glibc"
TERMUX_PKG_CMAKE_CROSSCOMPILING=false
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DINSTALL_UNIX_ADDRDIR=$TERMUX_PREFIX/var/run/mysqld.sock
-DINSTALL_SBINDIR=$TERMUX_PREFIX/bin
-DMYSQL_DATADIR=$TERMUX_PREFIX/var/lib/mysql
-DTMPDIR=$TERMUX_PREFIX_CLASSICAL/tmp
-DINSTALL_SYSCONFDIR=$TERMUX_PREFIX/etc
-DCOMPILATION_COMMENT="Termux"
-DINSTALL_SYSCONF2DIR=$TERMUX_PREFIX/etc/my.cnf.d
-DINSTALL_SCRIPTDIR=bin
-DINSTALL_INCLUDEDIR=include/mysql
-DINSTALL_PLUGINDIR=lib/mysql/plugin
-DINSTALL_SHAREDIR=share
-DINSTALL_SUPPORTFILESDIR=share/mysql
-DINSTALL_MYSQLSHAREDIR=share/mysql
-DINSTALL_DOCREADMEDIR=share/doc/mariadb
-DINSTALL_DOCDIR=share/doc/mariadb
-DINSTALL_MANDIR=share/man
-DDEFAULT_CHARSET=utf8mb4
-DDEFAULT_COLLATION=utf8mb4_unicode_ci
-DENABLED_LOCAL_INFILE=ON
-DPLUGIN_EXAMPLE=NO
-DPLUGIN_FEDERATED=NO
-DPLUGIN_FEEDBACK=NO
-DWITHOUT_MROONGA_STORAGE_ENGINE=1
-DWITH_EMBEDDED_SERVER=ON
-DWITH_EXTRA_CHARSETS=complex
-DWITH_JEMALLOC=ON
-DWITH_LIBWRAP=OFF
-DWITH_PCRE2=system
-DWITH_READLINE=ON
-DWITH_SSL=system
-DWITH_SYSTEMD=no
-DWITH_UNIT_TESTS=OFF
-DWITH_ZLIB=system
"
TERMUX_PKG_RM_AFTER_INSTALL="
glibc/bin/mysqltest*
glibc/share/man/man1/mysql-test-run.pl.1
glibc/share/mysql/mysql-test
glibc/mysql-test
glibc/sql-bench
glibc/mariadb-test
"

termux_step_pre_configure() {
	CFLAGS="${CFLAGS/_FORTIFY_SOURCE=3/_FORTIFY_SOURCE=2}"
	CXXFLAGS="${CXXFLAGS/_FORTIFY_SOURCE=3/_FORTIFY_SOURCE=2}"
}

termux_step_create_debscripts() {
	echo "if [ ! -e "$TERMUX_PREFIX/var/lib/mysql" ]; then" > postinst
	echo "  echo 'Initializing mysql data directory...'" >> postinst
	echo "  mkdir -p $TERMUX_PREFIX/var/lib/mysql" >> postinst
	echo "  LD_PRELOAD='' $TERMUX_PREFIX/bin/mysql_install_db --user=root --auth-root-authentication-method=normal --datadir=$TERMUX_PREFIX/var/lib/mysql --basedir=$TERMUX_PREFIX" >> postinst
	echo "fi" >> postinst
	echo "exit 0" >> postinst
	chmod 0755 postinst
}
