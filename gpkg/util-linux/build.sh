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
TERMUX_PKG_VERSION=2.39.3
TERMUX_PKG_SRCURL=https://www.kernel.org/pub/linux/utils/util-linux/v${TERMUX_PKG_VERSION:0:4}/util-linux-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=7b6605e48d1a49f43cc4b4cfc59f313d0dd5402fa40b96810bd572e167dfed0f
TERMUX_PKG_DEPENDS="libcap-ng-glibc, ncurses-glibc, zlib-glibc, libpam-glibc, libsmartcols-glibc, bash-glibc"
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
-Dbuild-python=disabled
"

termux_step_configure() {
	termux_step_configure_meson
}
