TERMUX_PKG_HOMEPAGE=https://e2fsprogs.sourceforge.net
TERMUX_PKG_DESCRIPTION="EXT 2/3/4 filesystem utilities"
TERMUX_PKG_LICENSE="GPL-2.0, LGPL-2.0"
TERMUX_PKG_LICENSE_FILE="NOTICE"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.47.0
TERMUX_PKG_SRCURL=https://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/v$TERMUX_PKG_VERSION/e2fsprogs-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=144af53f2bbd921cef6f8bea88bb9faddca865da3fbc657cc9b4d2001097d5db
TERMUX_PKG_CONFFILES="glibc/etc/mke2fs.conf"
TERMUX_PKG_NO_STATICSPLIT=true
TERMUX_PKG_DEPENDS="libblkid-glibc, libuuid-glibc, bash-glibc"

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--sbindir=${TERMUX_PREFIX}/bin
--with-crond_dir=${TERMUX_PREFIX}/etc/cron.d
--enable-symlink-install
--enable-symlink-build
--enable-relative-symlinks
--enable-elf-shlibs
--disable-fsck
--disable-uuidd
--disable-libuuid
--disable-libblkid
"

termux_step_make_install() {
	make install install-libs
	install -Dm600 \
		"$TERMUX_PKG_SRCDIR"/misc/mke2fs.conf.in \
		"$TERMUX_PREFIX"/etc/mke2fs.conf
}
