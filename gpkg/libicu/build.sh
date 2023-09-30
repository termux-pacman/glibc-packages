TERMUX_PKG_HOMEPAGE=http://site.icu-project.org/home
TERMUX_PKG_DESCRIPTION='International Components for Unicode library'
TERMUX_PKG_LICENSE="BSD"
# We override TERMUX_PKG_SRCDIR termux_step_post_get_source so need to do
# this hack to be able to find the license file.
TERMUX_PKG_LICENSE_FILE="../LICENSE"
TERMUX_PKG_MAINTAINER="@termux-pacman"
# Never forget to always bump revision of reverse dependencies and rebuild them
# when bumping "major" version.
TERMUX_PKG_VERSION=73.2
TERMUX_PKG_SRCURL=https://github.com/unicode-org/icu/releases/download/release-${TERMUX_PKG_VERSION//./-}/icu4c-${TERMUX_PKG_VERSION//./_}-src.tgz
TERMUX_PKG_SHA256=818a80712ed3caacd9b652305e01afc7fa167e6f2e94996da44b90c2ab604ce1
TERMUX_PKG_DEPENDS="gcc-libs-glibc, bash-glibc"
TERMUX_PKG_HOSTBUILD=true
TERMUX_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="--disable-samples --disable-tests"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--disable-samples --disable-tests --with-cross-build=$TERMUX_PKG_HOSTBUILD_DIR"

termux_step_post_get_source() {
	TERMUX_PKG_SRCDIR+="/source"
	find . -type f | xargs touch
}

termux_step_pre_configure() {
	if [ "$TERMUX_ARCH" = "x86_64" ] && [ "$TERMUX_ON_DEVICE_BUILD" = "false" ]; then
		export LD_LIBRARY_PATH="/usr/lib"
	fi
}
