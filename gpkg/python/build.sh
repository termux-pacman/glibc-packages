TERMUX_PKG_HOMEPAGE=https://www.python.org/
TERMUX_PKG_DESCRIPTION="The Python programming language"
TERMUX_PKG_LICENSE="custom"
TERMUX_PKG_LICENSE_FILE="LICENSE"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=3.12.7
_MAJOR_VERSION="${TERMUX_PKG_VERSION%.*}"
_SETUPTOOLS_VERSION=69.5.1
TERMUX_PKG_SRCURL=(https://www.python.org/ftp/python/${TERMUX_PKG_VERSION%rc*}/Python-${TERMUX_PKG_VERSION}.tar.xz
		https://github.com/pypa/setuptools/archive/refs/tags/v${_SETUPTOOLS_VERSION}.tar.gz)
TERMUX_PKG_SHA256=(24887b92e2afd4a2ac602419ad4b596372f67ac9b077190f459aba390faf5550
		2cf4ea407b1325c2c85862d13eb31f9b57098b0ae7f94e2258aea4e634f6534f)
TERMUX_PKG_DEPENDS="libbz2-glibc, libexpat-glibc, gdbm-glibc, libffi-glibc, libnsl-glibc, libxcrypt-glibc, openssl-glibc, zlib-glibc"
TERMUX_PKG_BUILD_DEPENDS="sqlite-glibc, mpdecimal-glibc, llvm-glibc"
TERMUX_PKG_PROVIDES="python3-glibc"
TERMUX_PKG_RM_AFTER_INSTALL="glibc/lib/python${_MAJOR_VERSION}/site-packages/*/"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure() {
	rm -rf Modules/expat
	rm -rf Modules/_decimal/libmpdec
	sed -e '/tag_build = .post/d' -e '/tag_date = 1/d' -i setuptools-${_SETUPTOOLS_VERSION}/setup.cfg

	export CFLAGS="${CFLAGS/-O2/-O3} -ffat-lto-objects"
}

termux_step_configure() {
	local _CONF_FLAG=""
	if [ "$TERMUX_ON_DEVICE_BUILD" = "false" ]; then
		_CONF_FLAG="--with-build-python=python${_MAJOR_VERSION}"
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
		ac_cv_func_link=no \
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

termux_step_post_make_install() {
	(
		export TERMUX_PKG_SETUP_PYTHON=true
		export TERMUX_SKIP_DEPCHECK=true
		export SETUPTOOLS_INSTALL_WINDOWS_SPECIFIC_FILES=0
		termux_step_get_dependencies_python

		cd ${TERMUX_PKG_SRCDIR}/setuptools-${_SETUPTOOLS_VERSION}
		pip install --no-deps . --target ${TERMUX_PKG_SRCDIR}/setuptools
		cp -r ${TERMUX_PKG_SRCDIR}/setuptools/setuptools/_distutils ${TERMUX_PYTHON_HOME}/distutils
	)
}
