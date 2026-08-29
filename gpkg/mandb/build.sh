TERMUX_PKG_DESCRIPTION="mandb manual reader "
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_VERSION=0
TERMUX_PKG_SRCURL=git+https://gitlab.com/man-db/man-db
TERMUX_PKG_GIT_BRANCH=main
TERMUX_PKG_DEPENDS="gdbm-glibc, glibc, libpipeline-glibc"
# TERMUX_PKG_BUILD_DEPENDS="less, libandroid-glob, zlib"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS=" --with-systemdsystemunitdir=no --with-systemdtmpfilesdir=no --disable-makeinstall-chown  ac_cv_func_chown=no " 
TERMUX_PKG_EXTRA_MAKE_ARGS=" V=1 VERBOSE=1 -j4 " 

termux_step_pre_configure() {
	# this server is down with 502 hosting problems using mirror instead 
	sed -i s,git.savannah.gnu.org/git/gnulib.git,github.com/mirror/gnulib, bootstrap
	# sed -i '1 a\set -x' bootstrap
	bootstrap
	# autogen --force
	# sed -i '1 a\set -x' configure
	# export MAKEFLAGS=-j4
	{
			echo "HAVE_CHOWN=0"
	} > configure.local
# :
}

# termux_step_configure() {
# 	pwd
# 	cd $TERMUX_PKG_SRCDIR
# 	configure
# }


termux_step_post_configure() {
	sed -i "s, install-exec-hook,," src/Makefile
# read -p yes?
}

termux_step_post_make_install() {
	cd $TERMUX_PREFIX/bin
	mv man mman
	mv whatis mwhatis
}

termux_step_post_massage() {
	mkdir -p glibc/etc
	echo "MANDATORY_MANPATH	$TERMUX_PREFIX/share/man" > glibc/etc/man_db.conf
}
