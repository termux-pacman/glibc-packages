TERMUX_PKG_HOMEPAGE=https://www.gnu.org/software/wget/
TERMUX_PKG_DESCRIPTION="Commandline tool for retrieving files using HTTP, HTTPS and FTP"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.21.4
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://mirrors.kernel.org/gnu/wget/wget-${TERMUX_PKG_VERSION}.tar.lz
TERMUX_PKG_SHA256=3683619a5f50edcbccb1720a79006fa37bf9b9a255a8c5b48048bc3c7a874bd9
TERMUX_PKG_DEPENDS="libidn2-glibc, libuuid-glibc, openssl-glibc, pcre2-glibc, zlib-glibc, libnettle-glibc, libpsl-glibc, libgnutls-glibc"
TERMUX_PKG_CONFFILES="glibc/etc/wgetrc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-rpath
--enable-nls
--with-ssl=openssl
"

termux_step_pre_configure() {
	LDFLAGS+=" -lbrotlicommon"
}
