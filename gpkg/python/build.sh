TERMUX_PKG_HOMEPAGE=https://www.python.org/
TERMUX_PKG_DESCRIPTION="The Python programming language"
TERMUX_PKG_LICENSE="custom"
TERMUX_PKG_LICENSE_FILE="LICENSE"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=3.11.9
_MAJOR_VERSION="${TERMUX_PKG_VERSION%.*}"
TERMUX_PKG_SRCURL=https://www.python.org/ftp/python/${TERMUX_PKG_VERSION%rc*}/Python-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=9b1e896523fc510691126c864406d9360a3d1e986acbda59cda57b5abda45b87
TERMUX_PKG_DEPENDS="libbz2-glibc, libexpat-glibc, gdbm-glibc, libffi-glibc, libnsl-glibc, libxcrypt-glibc, openssl-glibc, zlib-glibc"
TERMUX_PKG_BUILD_DEPENDS="sqlite-glibc, mpdecimal-glibc, llvm-glibc"
TERMUX_PKG_PROVIDES="python3-glibc"
TERMUX_PKG_RM_AFTER_INSTALL="glibc/lib/python${_MAJOR_VERSION}/site-packages/*/"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure() {
	rm -rf Modules/expat
	rm -r Modules/_ctypes/{darwin,libffi}*
	rm -rf Modules/_decimal/libmpdec

	export CFLAGS="${CFLAGS/-O2/-O3}"
}

termux_step_configure() {
	local _CONF_FLAG=""
	if [ "$TERMUX_ON_DEVICE_BUILD" = "false" ]; then
		_CONF_FLAG="--with-build-python=python$_MAJOR_VERSION"
	fi

	./configure --prefix=${TERMUX_PREFIX} \
		--build=${TERMUX_HOST_PLATFORM} \
		--host=${TERMUX_HOST_PLATFORM} \
		--target=${TERMUX_HOST_PLATFORM} \
		--enable-shared \
		--with-computed-gotos \
		--without-lto \
		--enable-ipv6 \
		--with-system-libmpdec \
		--with-system-expat \
		--with-dbmliborder=gdbm:ndbm \
		--enable-loadable-sqlite-extensions \
		--without-ensurepip \
		${_CONF_FLAG} \
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
