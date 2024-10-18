TERMUX_PKG_HOMEPAGE=https://github.com/rhash/RHash
TERMUX_PKG_DESCRIPTION="Console utility for calculation and verification of magnet links and a wide range of hash sums"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.4.5
TERMUX_PKG_SRCURL=https://github.com/rhash/RHash/archive/v$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=6db837e7bbaa7c72c5fd43ca5af04b1d370c5ce32367b9f6a1f7b49b2338c09a
TERMUX_PKG_DEPENDS="glibc"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_CONFFILES="glibc/etc/rhashrc"

termux_step_post_make_install() {
	make -C librhash install-lib-headers install-lib-shared install-so-link
}
