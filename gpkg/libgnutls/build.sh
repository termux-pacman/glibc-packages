TERMUX_PKG_HOMEPAGE=https://www.gnutls.org/
TERMUX_PKG_DESCRIPTION="Secure communications library implementing the SSL, TLS and DTLS protocols and technologies around them"
TERMUX_PKG_LICENSE="LGPL-2.1, GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux-pacmam"
_MAJOR_VERSION=3.8
TERMUX_PKG_VERSION=${_MAJOR_VERSION}.3
TERMUX_PKG_SRCURL=https://www.gnupg.org/ftp/gcrypt/gnutls/v${_MAJOR_VERSION}/gnutls-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=f74fc5954b27d4ec6dfbb11dea987888b5b124289a3703afcada0ee520f4173e
TERMUX_PKG_DEPENDS="libgmp-glibc, libtasn1-glibc, readline-glibc, zlib-glibc, libnettle-glibc, p11-kit-glibc, libidn2-glibc, zstd-glibc, libunistring-glibc, brotli-glibc"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
--with-idn
--with-brotli
--with-zstd
--enable-openssl-compatibility
--with-default-trust-store-pkcs11="pkcs11:"
"
#--with-tpm2
