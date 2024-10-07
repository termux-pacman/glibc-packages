TERMUX_PKG_HOMEPAGE=https://www.gnu.org/software/binutils/
TERMUX_PKG_DESCRIPTION="GNU Binutils libraries"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=2.43.1
TERMUX_PKG_SRCURL=https://ftp.gnu.org/gnu/binutils/binutils-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=13f74202a3c4c51118b797a39ea4200d3f6cfbe224da6d1d95bb938480132dfd
TERMUX_PKG_DEPENDS="glibc, libjansson-glibc, libelf-glibc, zlib-glibc, zstd-glibc"
TERMUX_PKG_CONFFILES="glibc/etc/gprofng.rc"
TERMUX_PKG_NO_STATICSPLIT=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--host=$TERMUX_HOST_PLATFORM
--build=$TERMUX_HOST_PLATFORM
--target=$TERMUX_HOST_PLATFORM
--sysconfdir=${TERMUX_PREFIX}/etc
--with-lib-path=${TERMUX_PREFIX}/lib
--with-bugurl=https://github.com/termux-pacman/glibc-packages/issues
--enable-colored-disassembly
--enable-default-execstack=no
--enable-deterministic-archives
--enable-gold
--enable-install-libiberty
--enable-jansson
--enable-ld=default
--enable-new-dtags
--enable-plugins
--enable-relro
--enable-shared
--enable-targets=bpf-unknown-none
--enable-threads
--disable-gdb
--disable-gdbserver
--disable-libdecnumber
--disable-readline
--disable-sim
--disable-werror
--with-debuginfod
--with-pic
--with-system-zlib
"

termux_step_pre_configure() {
	sed -i '/^development=/s/true/false/' ${TERMUX_PKG_SRCDIR}/bfd/development.sh
}

termux_step_make() {
	make -O tooldir=$TERMUX_PREFIX
}

termux_step_make_install() {
	make prefix=$TERMUX_PREFIX tooldir=$TERMUX_PREFIX install

	install -m644 libiberty/pic/libiberty.a $TERMUX_PREFIX/lib

	rm -f $TERMUX_PREFIX/share/man/man1/{dlltool,windres,windmc}*

	rm -f $TERMUX_PREFIX/lib/lib{bfd,opcodes}.so
	tee $TERMUX_PREFIX/lib/libbfd.so << EOS
/* GNU ld script */

INPUT( $TERMUX_PREFIX/lib/libbfd.a -lsframe -liberty -lz -lzstd -ldl )
EOS

	tee $TERMUX_PREFIX/lib/libopcodes.so << EOS
/* GNU ld script */

INPUT( $TERMUX_PREFIX/lib/libopcodes.a -lbfd )
EOS
}
