TERMUX_PKG_HOMEPAGE=https://www.gnu.org/software/findutils/
TERMUX_PKG_DESCRIPTION="Utilities to find files meeting specified criteria and perform various actions on the files which are found"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=4.9.0
TERMUX_PKG_SRCURL=https://mirrors.kernel.org/gnu/findutils/findutils-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=a2bfb8c09d436770edc59f50fa483e785b161a3b7b9d547573cb08065fd462fe
TERMUX_PKG_DEPENDS="glibc, bash-glibc"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_ESSENTIAL=true

termux_step_pre_configure() {
	autoreconf --force --install
	sed -e '/^SUBDIRS/s/locate//' -e 's/frcode locate updatedb//' -i Makefile.in
}

termux_step_post_configure() {
	make -C locate dblocation.texi
}
