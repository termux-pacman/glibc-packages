TERMUX_PKG_HOMEPAGE=https://people.redhat.com/sgrubb/libcap-ng/
TERMUX_PKG_DESCRIPTION="Library making programming with POSIX capabilities easier than traditional libcap"
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="0.8.4"
TERMUX_PKG_SRCURL=https://github.com/stevegrubb/libcap-ng/archive/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=5615c76a61039e283a6bd107c4faf345ae5ad4dcd45907defe5e474d8fdb6fd2
TERMUX_PKG_DEPENDS="glibc, gcc-libs-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--without-python
--without-python3
"

termux_step_pre_configure() {
	./autogen.sh
}
