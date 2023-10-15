TERMUX_PKG_HOMEPAGE=https://www.oracle.com/database/berkeley-db
TERMUX_PKG_DESCRIPTION="The Berkeley DB embedded database system (library)"
TERMUX_PKG_LICENSE="AGPL-V3"
# We override TERMUX_PKG_SRCDIR termux_step_pre_configure so need to do
# this hack to be able to find the license file.
TERMUX_PKG_LICENSE_FILE="../LICENSE"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=18.1.40
TERMUX_PKG_SRCURL=https://fossies.org/linux/misc/db-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=0cecb2ef0c67b166de93732769abdeba0555086d51de1090df325e18ee8da9c8
TERMUX_PKG_DEPENDS="gcc-libs-glibc, bash-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--enable-compat185
--enable-shared
--enable-static
--enable-cxx
--enable-dbm
--enable-stl
"

termux_step_pre_configure() {
	TERMUX_PKG_SRCDIR=$TERMUX_PKG_SRCDIR/dist
}
