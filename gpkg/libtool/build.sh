TERMUX_PKG_HOMEPAGE=https://www.gnu.org/software/libtool/
TERMUX_PKG_DESCRIPTION="Generic library support script hiding the complexity of using shared libraries behind a consistent, portable interface"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=2.5.3
TERMUX_PKG_SRCURL=https://mirrors.kernel.org/gnu/libtool/libtool-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=9322bd8f6bc848fda3e385899dd1934957169652acef716d19d19d24053abb95
TERMUX_PKG_DEPENDS="bash-glibc, grep-glibc, sed-glibc, tar-glibc, libltdl-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
lt_cv_sys_lib_search_path_spec=$TERMUX_PREFIX/lib
lt_cv_sys_lib_dlsearch_path_spec=$TERMUX_PREFIX/lib
"
TERMUX_PKG_NO_STATICSPLIT=true

termux_step_post_make_install() {
	sed -i "s#\(\"\| \|'\|\:\|\!\|\-\)\(/usr/bin/\|/bin/\)#\1$PREFIX/bin/#g" $TERMUX_PREFIX/bin/{libtool,libtoolize}
}
