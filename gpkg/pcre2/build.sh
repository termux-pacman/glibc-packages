TERMUX_PKG_HOMEPAGE=https://www.pcre.org
TERMUX_PKG_DESCRIPTION="Perl 5 compatible regular expression library"
TERMUX_PKG_LICENSE="BSD 3-Clause"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="10.44"
TERMUX_PKG_SRCURL=https://github.com/PhilipHazel/pcre2/releases/download/pcre2-${TERMUX_PKG_VERSION}/pcre2-${TERMUX_PKG_VERSION}.tar.bz2
TERMUX_PKG_SHA256=d34f02e113cf7193a1ebf2770d3ac527088d485d4e047ed10e5d217c6ef5de96
TERMUX_PKG_DEPENDS="readline-glibc, zlib-glibc, bash-glibc, libbz2-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--enable-pcre2-16
--enable-pcre2-32
--enable-jit
--enable-pcre2grep-libz
--enable-pcre2grep-libbz2
--enable-pcre2test-libreadline
"
