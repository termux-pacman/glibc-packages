TERMUX_PKG_HOMEPAGE=https://github.com/rhash/RHash
TERMUX_PKG_DESCRIPTION="Console utility for calculation and verification of magnet links and a wide range of hash sums"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.4.4
TERMUX_PKG_SRCURL=https://github.com/rhash/RHash/archive/v$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=8e7d1a8ccac0143c8fe9b68ebac67d485df119ea17a613f4038cda52f84ef52a
TERMUX_PKG_DEPENDS="glibc"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_CONFFILES="glibc/etc/rhashrc"

termux_step_post_make_install() {
	make -C librhash install-lib-headers install-lib-shared install-so-link
}
