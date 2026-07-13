TERMUX_PKG_HOMEPAGE=https://github.com/rhash/RHash
TERMUX_PKG_DESCRIPTION="Console utility for calculation and verification of magnet links and a wide range of hash sums"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.4.6
TERMUX_PKG_SRCURL=https://github.com/rhash/RHash/archive/v$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=9f6019cfeeae8ace7067ad22da4e4f857bb2cfa6c2deaa2258f55b2227ec937a
TERMUX_PKG_DEPENDS="glibc"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_CONFFILES="glibc/etc/rhashrc"

termux_step_post_make_install() {
	make -C librhash install-lib-headers install-lib-shared install-so-link
}
