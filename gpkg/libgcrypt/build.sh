TERMUX_PKG_HOMEPAGE=https://www.gnu.org/software/libgcrypt/
TERMUX_PKG_DESCRIPTION="General purpose cryptographic library based on the code from GnuPG"
TERMUX_PKG_LICENSE="GPL-2.0, LGPL-2.1, BSD 3-Clause, MIT, Public Domain"
TERMUX_PKG_LICENSE_FILE="COPYING, COPYING.LIB, LICENSES"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.11.0
TERMUX_PKG_SRCURL=https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-${TERMUX_PKG_VERSION}.tar.bz2
TERMUX_PKG_SHA256=09120c9867ce7f2081d6aaa1775386b98c2f2f246135761aae47d81f58685b9c
TERMUX_PKG_DEPENDS="libgpg-error-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-padlock-support
"

termux_step_pre_configure() {
	autoreconf -vfi
}
