TERMUX_PKG_HOMEPAGE=https://www.gnu.org/software/libtool/
TERMUX_PKG_DESCRIPTION="Generic library support script hiding the complexity of using shared libraries behind a consistent, portable interface"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=2.6.2
TERMUX_PKG_SRCURL=https://mirrors.kernel.org/gnu/libtool/libtool-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=24adb3aa9ae035c70faba344af57d73215eb89281045af6c7ccd307751f8b0bf
TERMUX_PKG_DEPENDS="bash-glibc, grep-glibc, sed-glibc, tar-glibc, libltdl-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
lt_cv_sys_lib_search_path_spec=$TERMUX_PREFIX/lib
lt_cv_sys_lib_dlsearch_path_spec=$TERMUX_PREFIX/lib
"
TERMUX_PKG_NO_STATICSPLIT=true

termux_step_post_make_install() {
	sed -i "s#\(\"\| \|'\|\:\|\!\|\-\)\(/usr/bin/\|/bin/\)#\1$PREFIX/bin/#g" $TERMUX_PREFIX/bin/{libtool,libtoolize}
}
