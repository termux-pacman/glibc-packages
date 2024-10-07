TERMUX_PKG_HOMEPAGE=https://libuv.org
TERMUX_PKG_DESCRIPTION="Support library with a focus on asynchronous I/O"
TERMUX_PKG_LICENSE="MIT, BSD 2-Clause, ISC, BSD 3-Clause"
TERMUX_PKG_LICENSE_FILE="LICENSE"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.49.1
TERMUX_PKG_SRCURL=https://dist.libuv.org/dist/v${TERMUX_PKG_VERSION}/libuv-v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=8d84f714f4cfd167b1576a58b82430cc2166ef135463d0644964fd71c61a6766
TERMUX_PKG_DEPENDS="libnsl-glibc"

termux_step_pre_configure() {
	./autogen.sh
}
