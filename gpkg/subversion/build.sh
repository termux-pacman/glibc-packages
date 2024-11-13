TERMUX_PKG_HOMEPAGE=https://subversion.apache.org
TERMUX_PKG_DESCRIPTION="Centralized version control system characterized by its simplicity"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.14.4
TERMUX_PKG_SRCURL=https://www.apache.org/dist/subversion/subversion-${TERMUX_PKG_VERSION}.tar.bz2
TERMUX_PKG_SHA256=44ead116e72e480f10f123c914bb6f9f8c041711c041ed7abff1b8634a199e3c
TERMUX_PKG_DEPENDS="gcc-libs-glibc, apr-util-glibc, serf-glibc, libexpat-glibc, libsqlite-glibc, liblz4-glibc, utf8proc-glibc, zlib-glibc"
TERMUX_PKG_BUILD_DEPENDS="python-glibc, libsecret-glibc, apache2-glibc, python-py3c-glibc, swig-glibc"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--with-apxs
--with-apache-libexecdir=$TERMUX_PREFIX/libexec/httpd/modules
--without-swig-ruby
--without-jdk
--with-apr=$TERMUX_PREFIX/bin/apr-1-config
--with-apr-util=$TERMUX_PREFIX/bin/apu-1-config
--with-swig-perl=$TERMUX_PREFIX/bin/perl
PYTHON=$TERMUX_PREFIX/bin/python3
"

termux_step_pre_configure() {
	if [ "$TERMUX_ARCH" != "i686" ]; then
		TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --with-gnome-keyring"
	fi
}

termux_step_make() {
	local site_packages=$($TERMUX_PREFIX/bin/python -c "import site; print(site.getsitepackages()[0])")
	make
	make swig_pydir=$site_packages/libsvn swig_pydir_extra=$site_packages/svn swig-py swig-pl
}

termux_step_make_install() {
	local site_packages=$($TERMUX_PREFIX/bin/python -c "import site; print(site.getsitepackages()[0])")

	make INSTALLDIRS=vendor \
		swig_pydir=$site_packages/libsvn \
		swig_pydir_extra=$site_packages/svn \
		install install-swig-py install-swig-pl

	install -dm755 $TERMUX_PREFIX/share/subversion
	cp -a tools/hook-scripts $TERMUX_PREFIX/share/subversion/
	rm $TERMUX_PREFIX/share/subversion/hook-scripts/*.in

	install -Dm 644 tools/client-side/bash_completion $TERMUX_PREFIX/share/bash-completion/completions/subversion
	for i in svn svnadmin svndumpfilter svnlook svnsync svnversion; do
		ln -sf subversion $TERMUX_PREFIX/share/bash-completion/completions/${i}
	done
}
