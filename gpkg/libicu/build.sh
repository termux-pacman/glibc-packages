TERMUX_PKG_HOMEPAGE=http://site.icu-project.org/home
TERMUX_PKG_DESCRIPTION='International Components for Unicode library'
TERMUX_PKG_LICENSE="BSD"
# We override TERMUX_PKG_SRCDIR termux_step_post_get_source so need to do
# this hack to be able to find the license file.
TERMUX_PKG_LICENSE_FILE="../LICENSE"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=74.2
TERMUX_PKG_SRCURL=https://github.com/unicode-org/icu/releases/download/release-${TERMUX_PKG_VERSION//./-}/icu4c-${TERMUX_PKG_VERSION//./_}-src.tgz
TERMUX_PKG_SHA256=5e4fb11d6a3e6b85afb55de8da8a71538f1d8fd64fce893986b37d60e5bb0091
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

termux_step_pre_configure() {
	if [ "$TERMUX_ARCH" = "x86_64" ] && [ "$TERMUX_ON_DEVICE_BUILD" = "false" ]; then
		export LD_LIBRARY_PATH="/usr/lib"
	fi
}
