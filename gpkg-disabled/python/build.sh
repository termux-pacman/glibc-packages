TERMUX_PKG_HOMEPAGE=https://www.python.org/
TERMUX_PKG_DESCRIPTION="The Python programming language"
TERMUX_PKG_LICENSE="custom"
TERMUX_PKG_LICENSE_FILE="LICENSE"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=3.12.0
_MAJOR_VERSION="${TERMUX_PKG_VERSION%.*}"
TERMUX_PKG_SRCURL=https://www.python.org/ftp/python/${TERMUX_PKG_VERSION%rc*}/Python-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=795c34f44df45a0e9b9710c8c71c15c671871524cd412ca14def212e8ccb155d
TERMUX_PKG_DEPENDS="libbz2-glibc, libexpat-glibc, gdbm-glibc, libffi-glibc, libnsl-glibc, libxcrypt-glibc, openssl-glibc, zlib-glibc"
TERMUX_PKG_BUILD_DEPENDS="sqlite-glibc, mpdecimal-glibc"
TERMUX_PKG_PROVIDES="python3-glibc"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure() {
	rm -rf Modules/expat
	rm -rf Modules/_decimal/libmpdec

	export CFLAGS="${CFLAGS/-O2/-O3}"
}

termux_step_configure() {
	./configure --prefix=${TERMUX_PREFIX} \
		--host=${TERMUX_HOST_PLATFORM} \
		--build=${TERMUX_HOST_PLATFORM} \
		--target=${TERMUX_HOST_PLATFORM} \
		--enable-shared \
		--with-computed-gotos \
		--without-lto \
		--enable-ipv6 \
		--with-system-expat \
		--with-dbmliborder=gdbm:ndbm \
		--with-system-libmpdec \
		--enable-loadable-sqlite-extensions \
		--without-ensurepip \
		LN='ln -s'
}

termux_step_make_install() {
	make install

	ln -sf python3 ${TERMUX_PREFIX}/bin/python
	ln -sf python3-config ${TERMUX_PREFIX}/bin/python-config
	ln -sf idle3 ${TERMUX_PREFIX}/bin/idle
	ln -sf pydoc3 ${TERMUX_PREFIX}/bin/pydoc
	ln -sf python${_MAJOR_VERSION}.1 ${TERMUX_PREFIX}/share/man/man1/python.1

	install -dm755 ${TERMUX_PREFIX}/lib/python${_MAJOR_VERSION}/Tools/{i18n,scripts}
	install -m755 Tools/i18n/{msgfmt,pygettext}.py ${TERMUX_PREFIX}/lib/python${_MAJOR_VERSION}/Tools/i18n/
	install -m755 Tools/scripts/{README,*py} ${TERMUX_PREFIX}/lib/python${_MAJOR_VERSION}/Tools/scripts/
}
