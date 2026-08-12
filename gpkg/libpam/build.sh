TERMUX_PKG_HOMEPAGE=http://linux-pam.org
TERMUX_PKG_DESCRIPTION="PAM (Pluggable Authentication Modules) library"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.7.2
TERMUX_PKG_SRCURL=https://github.com/linux-pam/linux-pam/releases/download/v$TERMUX_PKG_VERSION/Linux-PAM-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=3d86b6383fb5fd9eb9578d2cd47d92801191f4bf3f9bc61419bfefc8aa1e531a
TERMUX_PKG_DEPENDS="libxcrypt-glibc, gcc-libs-glibc"
TERMUX_PKG_RM_AFTER_INSTALL="glibc/bin"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Dlogind=disabled
-Deconf=disabled
-Dselinux=disabled
-Dpam_userdb=disabled
-Ddocbook-rng=$TERMUX_PKG_SRCDIR/docbookxi.rng
-Dvendordir=''
"

termux_step_pre_configure() {
	termux_download https://archive.docbook.org/xml/5.0/rng/docbookxi.rng \
		$TERMUX_PKG_SRCDIR/docbookxi.rng \
		SKIP_CHECKSUM
}
