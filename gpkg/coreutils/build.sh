TERMUX_PKG_HOMEPAGE=https://www.gnu.org/software/coreutils/
TERMUX_PKG_DESCRIPTION="Basic file, shell and text manipulation utilities from the GNU project"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=9.11
TERMUX_PKG_SRCURL=https://mirrors.kernel.org/gnu/coreutils/coreutils-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=394024eda0a5955217ceda9cd1201e65dc8fa3aa29c2951135a49521d57c3cc3
TERMUX_PKG_DEPENDS="openssl-glibc, libacl-glibc, libgmp-glibc, libcap-glibc"
TERMUX_PKG_ESSENTIAL=true

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--with-openssl
--enable-no-install-program=groups,hostname,kill,uptime
"
