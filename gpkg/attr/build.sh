TERMUX_PKG_HOMEPAGE=http://savannah.nongnu.org/projects/attr/
TERMUX_PKG_DESCRIPTION="Utilities for manipulating filesystem extended attributes"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=2.6.0
TERMUX_PKG_SRCURL=git+https://https.git.savannah.gnu.org/git/attr.git
TERMUX_PKG_DEPENDS="glibc, gcc-libs-glibc"
TERMUX_PKG_BUILD_DEPENDS="gettext-glibc"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure() {
	./autogen.sh
}
