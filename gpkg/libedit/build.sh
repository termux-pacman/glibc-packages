TERMUX_PKG_HOMEPAGE=https://thrysoee.dk/editline/
TERMUX_PKG_DESCRIPTION="Library providing line editing, history, and tokenization functions"
TERMUX_PKG_LICENSE="BSD 3-Clause"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=20230828-3.1
TERMUX_PKG_SRCURL=https://thrysoee.dk/editline/libedit-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=4ee8182b6e569290e7d1f44f0f78dac8716b35f656b76528f699c69c98814dad
TERMUX_PKG_DEPENDS="ncurses-glibc"
TERMUX_PKG_RM_AFTER_INSTALL="glibc/share/man/man3/history.3"
