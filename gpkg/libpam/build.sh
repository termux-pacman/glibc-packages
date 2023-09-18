TERMUX_PKG_HOMEPAGE=http://linux-pam.org
TERMUX_PKG_DESCRIPTION="PAM (Pluggable Authentication Modules) library"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.5.3
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://github.com/linux-pam/linux-pam/releases/download/v$TERMUX_PKG_VERSION/Linux-PAM-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=7ac4b50feee004a9fa88f1dfd2d2fa738a82896763050cd773b3c54b0a818283
TERMUX_PKG_DEPENDS="libxcrypt-glibc, gcc-libs-glibc"
TERMUX_PKG_RM_AFTER_INSTALL="glibc/bin"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--includedir=$TERMUX_PREFIX/include/security
--enable-logind
--disable-db
"
