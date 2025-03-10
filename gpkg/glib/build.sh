TERMUX_PKG_HOMEPAGE=https://developer.gnome.org/glib/
TERMUX_PKG_DESCRIPTION="Library providing core building blocks for libraries and applications written in C"
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="2.84.0"
TERMUX_PKG_SRCURL=https://ftp.gnome.org/pub/gnome/sources/glib/${TERMUX_PKG_VERSION%.*}/glib-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=f8823600cb85425e2815cfad82ea20fdaa538482ab74e7293d58b3f64a5aff6a
TERMUX_PKG_DEPENDS="libffi-glibc, pcre2-glibc, util-linux-glibc, zlib-glibc, openssl-glibc, libunwind-glibc, libmount-glibc"
TERMUX_PKG_BUILD_DEPENDS="gobject-introspection-glibc"
TERMUX_PKG_PYTHON_COMMON_DEPS="pygments, itstool, packaging, gi-docgen"
TERMUX_PKG_ACCEPT_PKG_IN_DEP=true
TERMUX_PKG_MESON_NATIVE=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--default-library both
-D runtime_dir=$TERMUX_PREFIX/var/run
-D glib_debug=disabled
-D documentation=true
-D introspection=enabled
-D man-pages=enabled
-D selinux=disabled
"

termux_step_pre_configure() {
	CFLAGS+=" -ffat-lto-objects"
	CXXFLAGS+=" -ffat-lto-objects"
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
