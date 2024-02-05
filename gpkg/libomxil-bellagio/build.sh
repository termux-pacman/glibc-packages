TERMUX_PKG_HOMEPAGE=http://omxil.sourceforge.net
TERMUX_PKG_DESCRIPTION="An opensource implementation of the OpenMAX Integration Layer API"
TERMUX_PKG_LICENSE="LGPL-3.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=0.9.3
TERMUX_PKG_SRCURL=https://downloads.sourceforge.net/project/omxil/omxil/Bellagio%200.9.3/libomxil-bellagio-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=593c0729c8ef8c1467b3bfefcf355ec19a46dd92e31bfc280e17d96b0934d74c
TERMUX_PKG_DEPENDS="glibc"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure() {
	sed -e 's/-Werror//' -i configure.ac
	CFLAGS+=' -fcommon'
	autoreconf -fiv
}
