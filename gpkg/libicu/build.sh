TERMUX_PKG_HOMEPAGE=http://site.icu-project.org/home
TERMUX_PKG_DESCRIPTION='International Components for Unicode library'
TERMUX_PKG_LICENSE="BSD"
# We override TERMUX_PKG_SRCDIR termux_step_post_get_source so need to do
# this hack to be able to find the license file.
TERMUX_PKG_LICENSE_FILE="../LICENSE"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=78.3
TERMUX_PKG_SRCURL=https://github.com/unicode-org/icu/releases/download/release-${TERMUX_PKG_VERSION}/icu4c-${TERMUX_PKG_VERSION}-sources.tgz
TERMUX_PKG_SHA256=3a2e7a47604ba702f345878308e6fefeca612ee895cf4a5f222e7955fabfe0c0
TERMUX_PKG_DEPENDS="gcc-libs-glibc, bash-glibc"
TERMUX_PKG_HOSTBUILD=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--with-cross-build=$TERMUX_PKG_HOSTBUILD_DIR"

termux_step_post_get_source() {
	rm ${TERMUX_PKG_SRCDIR}/LICENSE
	cp ${TERMUX_PKG_BUILDER_DIR}/LICENSE ${TERMUX_PKG_SRCDIR}
	TERMUX_PKG_SRCDIR+="/source"
	sed -r -i 's/(for ac_prog in )clang(\+\+)? /\1/g' ${TERMUX_PKG_SRCDIR}/configure
	find . -type f | xargs touch
}
