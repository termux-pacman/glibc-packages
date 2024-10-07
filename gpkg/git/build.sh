TERMUX_PKG_HOMEPAGE=https://git-scm.com/
TERMUX_PKG_DESCRIPTION="Fast, scalable, distributed revision control system"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="2.47.0"
TERMUX_PKG_SRCURL=https://mirrors.kernel.org/pub/software/scm/git/git-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=1ce114da88704271b43e027c51e04d9399f8c88e9ef7542dae7aebae7d87bc4e
TERMUX_PKG_DEPENDS="libcurl-glibc, libexpat-glibc, libiconv-glibc, openssl-glibc, pcre2-glibc, zlib-glibc, less-glibc"
TERMUX_PKG_SUGGESTS="perl-glibc"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_MAKE_ARGS="
SHELL_PATH=$TERMUX_PREFIX/bin/sh
PERL_PATH=$TERMUX_PREFIX/bin/perl
PYTHON_PATH=$TERMUX_PREFIX/bin/python
prefix=$TERMUX_PREFIX
gitexecdir=$TERMUX_PREFIX/libexec/git-core
INSTALL_SYMLINKS=1
NO_INSTALL_HARDLINKS=1
MAN_BOLD_LITERAL=1
NO_PERL_CPAN_FALLBACKS=1
USE_LIBPCRE2=1
"
_make() {
	make -j $TERMUX_PKG_MAKE_PROCESSES $@ ${TERMUX_PKG_EXTRA_MAKE_ARGS}
}

termux_step_configure() {
	TERMUX_PKG_EXTRA_MAKE_ARGS+=" perllibdir=$($TERMUX_PREFIX/bin/perl -MConfig -wle 'print $Config{installvendorlib}')"
}

termux_step_make() {
	_make all man
	_make -C contrib/credential/libsecret
	_make -C contrib/subtree all man
	_make -C contrib/mw-to-git all
	_make -C contrib/diff-highlight
}

termux_step_make_install() {
	_make install install-man

	# bash completion
	mkdir -p $TERMUX_PREFIX/share/bash-completion/completions/
	install -m 0644 ./contrib/completion/git-completion.bash $TERMUX_PREFIX/share/bash-completion/completions/git
	# fancy git prompt
	mkdir -p $TERMUX_PREFIX/share/git/
	install -m 0644 ./contrib/completion/git-prompt.sh $TERMUX_PREFIX/share/git/git-prompt.sh
	# libsecret credentials helper
	install -m 0755 contrib/credential/libsecret/git-credential-libsecret \
		$TERMUX_PREFIX/libexec/git-core/git-credential-libsecret
	_make -C contrib/credential/libsecret clean
	# subtree installation
	_make -C contrib/subtree install install-man
	# mediawiki installation
	_make -C contrib/mw-to-git install
	# the rest of the contrib stuff
	find contrib/ -name '.gitignore' -delete
	cp -a ./contrib/* $TERMUX_PREFIX/share/git/
}
