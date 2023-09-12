TERMUX_PKG_HOMEPAGE=https://github.com/latchset/libverto
TERMUX_PKG_DESCRIPTION="Main event loop abstraction library"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=0.3.2
TERMUX_PKG_SRCURL=https://github.com/latchset/libverto/releases/download/$TERMUX_PKG_VERSION/libverto-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=8d1756fd704f147549f606cd987050fb94b0b1ff621ea6aa4d6bf0b74450468a
TERMUX_PKG_DEPENDS="libevent-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
--with-libevent
--without-libev
--without-glib
"
