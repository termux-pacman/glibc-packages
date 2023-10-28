TERMUX_PKG_HOMEPAGE=https://curl.se/
TERMUX_PKG_DESCRIPTION="Easy-to-use client-side URL transfer library"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=8.4.0
TERMUX_PKG_SRCURL=https://github.com/curl/curl/releases/download/curl-${TERMUX_PKG_VERSION//./_}/curl-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=16c62a9c4af0f703d28bda6d7bbf37ba47055ad3414d70dec63e2e6336f2a82d
TERMUX_PKG_DEPENDS="libnghttp2-glibc, libssh2-glibc, openssl-glibc (>= 3.0.3), krb5-glibc, brotli-glibc"
TERMUX_PKG_ESSENTIAL=true
TERMUX_PKG_EXTRA_MAKE_ARGS="LDFLAGS='-lbrotlidec'"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--with-ca-bundle=$TERMUX_PREFIX/etc/ssl/certs/ca-certificates.crt
--with-ca-path=$TERMUX_PREFIX/etc/ssl/certs
--disable-ldap
--disable-ldaps
--disable-manual
--enable-ipv6
--enable-threaded-resolver
--with-libssh2
--with-openssl
--enable-versioned-symbols
--with-random=/dev/urandom
"

termux_step_pre_configure() {
	# Configure compiles binaries for testing that return a `Segmentation fault (core dumped)` error when run.
	# I don't know why this happens like this.
	sed -i 's/cross_compiling=no/cross_compiling=yes/' ${TERMUX_PKG_SRCDIR}/configure
}
