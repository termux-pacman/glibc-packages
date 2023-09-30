TERMUX_PKG_HOMEPAGE=https://www.gnu.org/software/gettext/
TERMUX_PKG_DESCRIPTION="GNU Internationalization utilities"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="0.22.2"
TERMUX_PKG_SRCURL=https://mirrors.kernel.org/gnu/gettext/gettext-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=4c82fbfe5e53d71a97c634aa98a898b9da807b08b27410f6a4641e8bb44dc4b2
TERMUX_PKG_DEPENDS="gcc-libs-glibc, libacl-glibc, bash-glibc, libunistring-glibc, libxml2-glibc"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--enable-csharp
--enable-nls
--with-xz
--without-included-gettext
"
