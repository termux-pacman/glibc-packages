TERMUX_PKG_HOMEPAGE=https://nodejs.org/
TERMUX_PKG_DESCRIPTION="Open Source JavaScript runtime built on V8 JavaScript engine"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=22.11.0
TERMUX_PKG_SRCURL=https://nodejs.org/dist/v${TERMUX_PKG_VERSION}/node-v${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=66a539a0e7528b0b2e1a4e559fc2e8b0a3f88b079c77c57f33e6f68e2c08e58e
TERMUX_PKG_DEPENDS="glibc, openssl-glibc, libuv-glibc, zlib-glibc, libnghttp2-glibc, libicu-glibc, gcc-libs-glibc, python-glibc"
TERMUX_PKG_BUILD_DEPENDS="pkgconf-glibc"
TERMUX_PKG_NO_STATICSPLIT=true
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_configure() {
	local _target_arch=""
	case "$TERMUX_ARCH" in
		aarch64) _target_arch="arm64" ;;
		arm)     _target_arch="arm" ;;
		x86_64)  _target_arch="x64" ;;
		i686)    _target_arch="x86" ;;
	esac

	export CC_host=gcc
	export CXX_host=g++

	./configure \
		--prefix="$TERMUX_PREFIX" \
		--dest-cpu="$_target_arch" \
		--dest-os=linux \
		--with-intl=system-icu \
		--shared-openssl \
		--shared-zlib \
		--shared-libuv \
		--openssl-use-def-ca-store \
		--without-snapshot \
		--without-node-code-cache \
		--without-corepack \
		--cross-compiling
}
