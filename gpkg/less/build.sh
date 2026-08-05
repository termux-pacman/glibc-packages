TERMUX_PKG_HOMEPAGE=https://www.greenwoodsoftware.com/less/
TERMUX_PKG_DESCRIPTION="Terminal pager program used to view the contents of a text file one screen at a time"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=704
TERMUX_PKG_SRCURL=https://www.greenwoodsoftware.com/less/less-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=20a0b0a2bb2525fa53c7eee9beb854b4c9cf172eabb209af7020743547bfe9fb
TERMUX_PKG_DEPENDS="ncurses-glibc, pcre2-glibc"
TERMUX_PKG_ESSENTIAL=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--with-regex=pcre2"
