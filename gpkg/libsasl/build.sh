TERMUX_PKG_HOMEPAGE=https://www.cyrusimap.org/sasl/
TERMUX_PKG_DESCRIPTION="Cyrus SASL - authentication abstraction library"
TERMUX_PKG_LICENSE="BSD"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=2.1.28
TERMUX_PKG_SRCURL=https://fossies.org/linux/misc/cyrus-sasl-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=67f1945057d679414533a30fe860aeb2714f5167a8c03041e023a65f629a9351
TERMUX_PKG_DEPENDS="gdbm-glibc, openssl-glibc"
TERMUX_PKG_BUILD_DEPENDS="mariadb-glibc, krb5-glibc, postgresql-glibc"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-krb4
--disable-macos-framework
--disable-otp
--disable-passdss
--disable-srp
--disable-srp-setpass
--disable-static
--enable-alwaystrue
--enable-anon
--enable-auth-sasldb
--enable-checkapop
--enable-cram
--enable-digest
--enable-gssapi
--enable-login
--enable-ntlm
--enable-plain
--enable-shared
--enable-sql
--with-dblib=gdbm
--with-devrandom=/dev/urandom
--with-configdir=$TERMUX_PREFIX/etc/sasl2:$TERMUX_PREFIX/etc/sasl:$TERMUX_PREFIX/lib/sasl2
--with-mysql=$TERMUX_PREFIX
--with-pam
--with-pgsql=$TERMUX_PREFIX/lib
--with-saslauthd=$TERMUX_PREFIX/var/run/saslauthd
--with-sqlite3=$TERMUX_PREFIX/lib
"

termux_step_pre_configure() {
	autoreconf -fiv
}

termux_step_post_configure() {
	sed -i -e 's/ -shared / -Wl,-O1,--as-needed\0/g' libtool
}
