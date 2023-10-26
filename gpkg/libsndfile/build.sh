TERMUX_PKG_HOMEPAGE=http://www.mega-nerd.com/libsndfile
TERMUX_PKG_DESCRIPTION="Library for reading/writing audio files"
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="1.2.2"
TERMUX_PKG_SRCURL=https://github.com/libsndfile/libsndfile/archive/refs/tags/${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=ffe12ef8add3eaca876f04087734e6e8e029350082f3251f565fa9da55b52121
TERMUX_PKG_DEPENDS="libflac-glibc, libogg-glibc, libopus-glibc, libvorbis-glibc, libmpg123-glibc, libmp3lame-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
-DENABLE_EXTERNAL_LIBS=ON
-DENABLE_MPEG=ON
"

termux_step_pre_configure() {
	CFLAGS+=" -lm"
}
