TERMUX_PKG_HOMEPAGE=http://linux-pam.org
TERMUX_PKG_DESCRIPTION="PAM (Pluggable Authentication Modules) library"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.6.1
TERMUX_PKG_SRCURL=https://github.com/linux-pam/linux-pam/releases/download/v$TERMUX_PKG_VERSION/Linux-PAM-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=f8923c740159052d719dbfc2a2f81942d68dd34fcaf61c706a02c9b80feeef8e
TERMUX_PKG_DEPENDS="libxcrypt-glibc, gcc-libs-glibc"
TERMUX_PKG_RM_AFTER_INSTALL="glibc/bin"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--includedir=$TERMUX_PREFIX/include/security
--disable-logind
--disable-db
"
