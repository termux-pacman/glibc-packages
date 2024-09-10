TERMUX_PKG_HOMEPAGE=https://en.wikipedia.org/wiki/Util-linux
TERMUX_PKG_DESCRIPTION="Miscellaneous system utilities"
TERMUX_PKG_LICENSE="GPL-3.0, GPL-2.0, LGPL-2.1, BSD 3-Clause, BSD, ISC"
TERMUX_PKG_LICENSE_FILE="\
Documentation/licenses/COPYING.GPL-3.0-or-later
Documentation/licenses/COPYING.GPL-2.0-or-later
Documentation/licenses/COPYING.LGPL-2.1-or-later
Documentation/licenses/COPYING.BSD-3-Clause
Documentation/licenses/COPYING.BSD-4-Clause-UC
Documentation/licenses/COPYING.ISC"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=2.40.2
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://github.com/util-linux/util-linux/archive/refs/tags/v${TERMUX_PKG_VERSION}.zip
TERMUX_PKG_SHA256=93780a9f9ccf2702e4166cbe71cba31cc65fcec688b0465828c9252fd62140ab
TERMUX_PKG_DEPENDS="libcap-ng-glibc, ncurses-glibc, zlib-glibc, libpam-glibc, libsmartcols-glibc, bash-glibc"
TERMUX_PKG_BUILD_DEPENDS="python-glibc"
TERMUX_PKG_ESSENTIAL=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Dlibuser=disabled
-Dncurses=disabled
-Dncursesw=enabled
-Deconf=disabled
-Dbuild-chfn-chsh=enabled
-Dbuild-line=disabled
-Dbuild-mesg=enabled
-Dbuild-newgrp=enabled
-Dbuild-vipw=enabled
-Dbuild-write=enabled
-Dbuild-lslogins=disabled
-Dbuild-login=disabled
-Dbuild-nologin=disabled
-Dbuild-sulogin=disabled
-Dbuild-su=disabled
-Dbuild-lsmem=disabled
-Dbuild-chmem=disabled
-Dpython=$TERMUX_PREFIX/bin/python
"

termux_step_configure() {
	termux_step_configure_meson
}
