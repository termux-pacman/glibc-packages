TERMUX_PKG_HOMEPAGE=https://lame.sourceforge.io/
TERMUX_PKG_DESCRIPTION="High quality MPEG Audio Layer III (MP3) encoder"
TERMUX_PKG_LICENSE="LGPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=3.100
TERMUX_PKG_SRCURL=https://downloads.sourceforge.net/project/lame/lame/${TERMUX_PKG_VERSION}/lame-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=ddfe36cab873794038ae2c1210557ad34857a4b6bdc515785d1da9e175b1da1e
TERMUX_PKG_DEPENDS="ncurses-glibc"

termux_step_post_make_install() {
	local _pkgconfig_dir=$TERMUX_PREFIX/lib/pkgconfig
	mkdir -p ${_pkgconfig_dir}
	sed -e "s|@TERMUX_PREFIX@|$TERMUX_PREFIX|" \
            -e "s|@TERMUX_PKG_VERSION@|$TERMUX_PKG_VERSION|" \
            $TERMUX_PKG_BUILDER_DIR/lame.pc.in > ${_pkgconfig_dir}/lame.pc
}
