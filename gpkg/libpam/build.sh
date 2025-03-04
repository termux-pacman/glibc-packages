TERMUX_PKG_HOMEPAGE=http://linux-pam.org
TERMUX_PKG_DESCRIPTION="PAM (Pluggable Authentication Modules) library"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.7.0
TERMUX_PKG_SRCURL=https://github.com/linux-pam/linux-pam/releases/download/v$TERMUX_PKG_VERSION/Linux-PAM-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=57dcd7a6b966ecd5bbd95e1d11173734691e16b68692fa59661cdae9b13b1697
TERMUX_PKG_DEPENDS="libxcrypt-glibc, gcc-libs-glibc"
TERMUX_PKG_RM_AFTER_INSTALL="glibc/bin"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--includedir=$TERMUX_PREFIX/include/security
-Dlogind=disabled
-Deconf=disabled
-Dselinux=disabled
-Dpam_userdb=disabled
-Ddocbook-rng=$TERMUX_PKG_SRCDIR/docbookxi.rng
"

termux_step_pre_configure() {
	termux_download https://docbook.org/xml/5.0/rng/docbookxi.rng \
		$TERMUX_PKG_SRCDIR/docbookxi.rng \
		SKIP_CHECKSUM
}
