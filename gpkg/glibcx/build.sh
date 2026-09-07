TERMUX_PKG_HOMEPAGE=https://github.com/dsecurity49/glibcx
TERMUX_PKG_DESCRIPTION="Native-speed glibc binary runner and patcher for Termux"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@dsecurity49"
TERMUX_PKG_VERSION=0.3.1
TERMUX_PKG_SRCURL=https://github.com/dsecurity49/glibcx/archive/refs/tags/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=9e807594d3c14ef1c2201f582cbde24e72cede273cfccbfc4a117d699a6a9906
TERMUX_PKG_DEPENDS="glibc-runner, bash, binutils, clang, curl, file, gnupg, jq, util-linux"
TERMUX_PKG_SUGGESTS="nodejs, unzip"
TERMUX_PKG_EXCLUDED_ARCHES="arm, i686, x86_64"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make() {
	bash ./build.sh
}

termux_step_make_install() {
	install -Dm755 glibcx-bin "$TERMUX_PREFIX/bin/glibcx"
	install -Dm644 keys/glibcx-release.gpg \
		"$TERMUX_PREFIX/share/glibcx/keys/glibcx-release.gpg"
}
