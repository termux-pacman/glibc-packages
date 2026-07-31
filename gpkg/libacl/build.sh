TERMUX_PKG_HOMEPAGE=https://savannah.nongnu.org/projects/acl/
TERMUX_PKG_DESCRIPTION="Access control list utilities, libraries and headers"
TERMUX_PKG_LICENSE="LGPL-2.1, GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=2.4.0
TERMUX_PKG_SRCURL=git+https://https.git.savannah.gnu.org/git/acl.git
TERMUX_PKG_DEPENDS="attr-glibc"

termux_step_pre_configure() {
	./autogen.sh
}
