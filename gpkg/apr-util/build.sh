TERMUX_PKG_HOMEPAGE=https://apr.apache.org/
TERMUX_PKG_DESCRIPTION="Apache Portable Runtime Utility Library"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.6.3
TERMUX_PKG_SRCURL=https://downloads.apache.org/apr/apr-util-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=2b74d8932703826862ca305b094eef2983c27b39d5c9414442e9976a9acf1983
TERMUX_PKG_DEPENDS="apr-glibc, libxcrypt-glibc, libexpat-glibc, libiconv-glibc, libuuid-glibc"
TERMUX_PKG_BUILD_DEPENDS="gdbm-glibc, openssl-glibc, sqlite-glibc, python-glibc, libdb-glibc, openldap-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--with-apr=$TERMUX_PREFIX
--with-ldap
--with-crypto
--with-gdbm=$TERMUX_PREFIX
--with-sqlite3=$TERMUX_PREFIX
--with-nss=$TERMUX_PREFIX
--with-odbc=$TERMUX_PREFIX
--with-berkeley-db=$TERMUX_PREFIX
--with-pgsql=$TERMUX_PREFIX
--with-mysql=$TERMUX_PREFIX
--with-oracle=$TERMUX_PREFIX
--with-openssl=$TERMUX_PREFIX
"
