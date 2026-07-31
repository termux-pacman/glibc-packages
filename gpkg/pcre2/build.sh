TERMUX_PKG_HOMEPAGE=https://www.pcre.org
TERMUX_PKG_DESCRIPTION="Perl 5 compatible regular expression library"
TERMUX_PKG_LICENSE="BSD 3-Clause"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="10.47"
TERMUX_PKG_SRCURL=https://github.com/PhilipHazel/pcre2/releases/download/pcre2-${TERMUX_PKG_VERSION}/pcre2-${TERMUX_PKG_VERSION}.tar.bz2
TERMUX_PKG_SHA256=47fe8c99461250d42f89e6e8fdaeba9da057855d06eb7fc08d9ca03fd08d7bc7
TERMUX_PKG_DEPENDS="readline-glibc, zlib-glibc, bash-glibc, libbz2-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--enable-pcre2-16
--enable-pcre2-32
--enable-jit
--enable-pcre2grep-libz
--enable-pcre2grep-libbz2
--enable-pcre2test-libreadline
"
