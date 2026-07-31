TERMUX_PKG_HOMEPAGE=https://www.gnupg.org/related_software/libgpg-error/
TERMUX_PKG_DESCRIPTION="Small library that defines common error values for all GnuPG components"
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.61
TERMUX_PKG_SRCURL=https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-${TERMUX_PKG_VERSION}.tar.bz2
TERMUX_PKG_SHA256=7a85413f2bc354f4f8aa832b718af122e48965e9e0eb9012ee659c13c6385c93
TERMUX_PKG_DEPENDS="glibc, bash-glibc"

termux_step_pre_configure() {
	autoreconf -vfi
}
