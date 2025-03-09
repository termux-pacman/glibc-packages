TERMUX_PKG_HOMEPAGE=https://www.openssl.org/
TERMUX_PKG_DESCRIPTION="Library implementing the SSL and TLS protocols as well as general purpose cryptography functions"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=3.4.1
TERMUX_PKG_SRCURL=https://github.com/openssl/openssl/releases/download/openssl-${TERMUX_PKG_VERSION}/openssl-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=002a2d6b30b58bf4bea46c43bdd96365aaf8daa6c428782aa4feee06da197df3
TERMUX_PKG_DEPENDS="ca-certificates-glibc, resolv-conf, zlib-glibc, gcc-libs-glibc"
TERMUX_PKG_CONFFILES="glibc/etc/ssl/openssl.cnf, glibc/etc/resolv.conf, glibc/etc/hosts"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_configure() {
	local openssltarget=""
	local optflags=""
	if [ "${TERMUX_ARCH}" = "arm" ]; then
		openssltarget='linux-armv4'
	elif [ "${TERMUX_ARCH}" = "aarch64" ]; then
		openssltarget='linux-aarch64'
		optflags='no-afalgeng'
	elif [ "${TERMUX_ARCH}" = "x86_64" ]; then
		openssltarget='linux-x86_64'
		optflags='enable-ec_nistp_64_gcc_128'
	elif [ "${TERMUX_ARCH}" = "i686" ]; then
		openssltarget='linux-generic32'
		optflags='no-sse2'
	fi

	./Configure --prefix=$TERMUX_PREFIX --openssldir=$TERMUX_PREFIX/etc/ssl --libdir=lib \
		shared enable-ktls ${optflags} "${openssltarget}"
}

termux_step_make() {
	make depend
	make
}

termux_step_make_install() {
	make MANDIR=$TERMUX_PREFIX/share/man MANSUFFIX=ssl install_sw install_ssldirs install_man_docs
	ln -s $TERMUX_PREFIX_CLASSICAL/etc/resolv.conf $TERMUX_PREFIX/etc
	ln -s $TERMUX_PREFIX_CLASSICAL/etc/hosts $TERMUX_PREFIX/etc
}
