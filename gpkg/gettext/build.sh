TERMUX_PKG_HOMEPAGE=https://www.gnu.org/software/gettext/
TERMUX_PKG_DESCRIPTION="GNU Internationalization utilities"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="0.22.3"
TERMUX_PKG_SRCURL=https://mirrors.kernel.org/gnu/gettext/gettext-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=b838228b3f8823a6c1eddf07297197c4db13f7e1b173b9ef93f3f945a63080b6
TERMUX_PKG_DEPENDS="gcc-libs-glibc, libacl-glibc, bash-glibc, libunistring-glibc, libxml2-glibc"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--enable-csharp
--enable-nls
--with-xz
--without-included-gettext
"
