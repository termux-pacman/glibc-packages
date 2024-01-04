TERMUX_PKG_HOMEPAGE=https://developer.gnome.org/glib/
TERMUX_PKG_DESCRIPTION="Library providing core building blocks for libraries and applications written in C"
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="2.78.3"
TERMUX_PKG_SRCURL=https://ftp.gnome.org/pub/gnome/sources/glib/${TERMUX_PKG_VERSION%.*}/glib-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=609801dd373796e515972bf95fc0b2daa44545481ee2f465c4f204d224b2bc21
TERMUX_PKG_DEPENDS="libffi-glibc, pcre2-glibc, util-linux-glibc, zlib-glibc, openssl-glibc, libunwind-glibc"
TERMUX_PKG_PYTHON_COMMON_DEPS="pygments, itstool"
# -Dgtk_doc=true
# -Dsysprof=enabled
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--default-library both
-Druntime_dir=$TERMUX_PREFIX/var/run
-Dglib_debug=disabled
-Dselinux=disabled
-Dman=true
"

termux_step_pre_configure() {
	CFLAGS+=" -g3 -ffat-lto-objects"
	CXXFLAGS+=" -g3 -ffat-lto-objects"
}

termux_step_create_debscripts() {
	for i in postinst postrm triggers; do
		sed \
			"s|@TERMUX_PREFIX@|${TERMUX_PREFIX}|g; s|@TERMUX_PREFIX_CLASSICAL@|${TERMUX_PREFIX_CLASSICAL}|g" \
			"${TERMUX_PKG_BUILDER_DIR}/hooks/${i}.in" > ./${i}
		chmod 755 ./${i}
	done
	unset i
	chmod 644 ./triggers
}
