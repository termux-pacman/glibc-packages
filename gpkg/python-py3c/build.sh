TERMUX_PKG_HOMEPAGE=https://github.com/encukou/py3c
TERMUX_PKG_DESCRIPTION="A Python 2/3 compatibility layer for C extensions"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_LICENSE_FILE="LICENSE.MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.4
TERMUX_PKG_SRCURL=https://github.com/encukou/py3c/archive/v$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=abc745079ef906148817f4472c3fb4bc41d62a9ea51a746b53e09819494ac006
TERMUX_PKG_DEPENDS="python-glibc"
TERMUX_PKG_PYTHON_COMMON_DEPS="setuptools==67.8"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_PLATFORM_INDEPENDENT=true

termus_step_configure() {
	python setup.py build
}

termux_step_make() {
	make prefix=$TERMUX_PREFIX py3c.pc
}

termux_step_post_make_install() {
	make prefix=$TERMUX_PREFIX install
	rm -fr $TERMUX_PREFIX/include/site
}

termux_step_post_massage() {
	rm -fr ${TERMUX_PKG_MASSAGEDIR}${TERMUX_PREFIX}/include/python*
}
