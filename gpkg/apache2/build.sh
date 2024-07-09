TERMUX_PKG_HOMEPAGE=https://httpd.apache.org
TERMUX_PKG_DESCRIPTION="Apache Web Server"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=2.4.61
TERMUX_PKG_SRCURL=https://www.apache.org/dist/httpd/httpd-${TERMUX_PKG_VERSION}.tar.bz2
TERMUX_PKG_SHA256=ea8ba86fd95bd594d15e46d25ac5bbda82ae0c9122ad93998cc539c133eaceb6
TERMUX_PKG_DEPENDS="zlib-glibc, apr-util-glibc, pcre2-glibc, libnghttp2-glibc, openssl-glibc, libxcrypt-glibc"
TERMUX_PKG_BUILD_DEPENDS="libcurl-glibc, libjansson-glibc, brotli-glibc, libdb-glibc"
TERMUX_PKG_CONFFILES="
glibc/etc/apache2/httpd.conf
glibc/etc/apache2/extra/httpd-autoindex.conf
glibc/etc/apache2/extra/httpd-dav.conf
glibc/etc/apache2/extra/httpd-default.conf
glibc/etc/apache2/extra/httpd-info.conf
glibc/etc/apache2/extra/httpd-languages.conf
glibc/etc/apache2/extra/httpd-manual.conf
glibc/etc/apache2/extra/httpd-mpm.conf
glibc/etc/apache2/extra/httpd-multilang-errordoc.conf
glibc/etc/apache2/extra/httpd-ssl.conf
glibc/etc/apache2/extra/httpd-userdir.conf
glibc/etc/apache2/extra/httpd-vhosts.conf
glibc/etc/apache2/extra/proxy-html.conf
glibc/etc/apache2/mime.types
glibc/etc/apache2/magic
"

# providing manual paths to libs because it picks up host libs on some systems
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--enable-layout=Termux
--enable-mpms-shared=all
--enable-modules=all
--enable-mods-shared=all
--enable-so
--enable-suexec
--with-suexec-caller=http
--with-suexec-logfile=$TERMUX_PREFIX/var/log/httpd/suexec.log
--with-suexec-bin=$TERMUX_PREFIX/bin/suexec
--libexecdir=$TERMUX_PREFIX/libexec/apache2
--with-suexec-uidmin=99
--with-suexec-gidmin=99
--enable-ldap
--enable-authnz-ldap
--enable-authnz-fcgi
--enable-cache
--enable-disk-cache
--enable-mem-cache
--enable-file-cache
--enable-ssl
--with-ssl
--enable-deflate
--enable-cgi
--enable-cgid
--enable-proxy
--enable-proxy-connect
--enable-proxy-http
--enable-proxy-ftp
--enable-dbd
--enable-imagemap
--enable-ident
--enable-cern-meta
--enable-http2
--enable-proxy-http2
--enable-md
--enable-brotli
--with-apr=$TERMUX_PREFIX/bin/apr-1-config
--with-apr-util=$TERMUX_PREFIX/bin/apu-1-config
--with-z=$TERMUX_PREFIX
--target=$TERMUX_HOST_PLATFORM
--with-pcre=$TERMUX_PREFIX
PCRE_CONFIG=$TERMUX_PREFIX/bin/pcre2-config
"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure() {
	# use custom layout
	cat $TERMUX_PKG_BUILDER_DIR/Termux.layout > $TERMUX_PKG_SRCDIR/config.layout
}

termux_step_post_make_install() {
	sed -e "s#/$TERMUX_PREFIX/libexec/apache2/#modules/#" \
		-e 's|#\(LoadModule negotiation_module \)|\1|' \
		-e 's|#\(LoadModule include_module \)|\1|' \
		-e 's|#\(LoadModule userdir_module \)|\1|' \
		-e 's|#\(LoadModule slotmem_shm_module \)|\1|' \
		-e 's|#\(Include extra/httpd-multilang-errordoc.conf\)|\1|' \
		-e 's|#\(Include extra/httpd-autoindex.conf\)|\1|' \
		-e 's|#\(Include extra/httpd-languages.conf\)|\1|' \
		-e 's|#\(Include extra/httpd-userdir.conf\)|\1|' \
		-e 's|#\(Include extra/httpd-default.conf\)|\1|' \
		-e 's|#\(Include extra/httpd-mpm.conf\)|\1|' \
		-e 's|User daemon|#User daemon|' \
		-e 's|Group daemon|#Group daemon|' \
		-i "$TERMUX_PREFIX/etc/apache2/httpd.conf"
	echo -e "#\n#  Load config files from the config directory 'conf.d'.\n#\nInclude etc/apache2/conf.d/*.conf" >> $TERMUX_PREFIX/etc/apache2/httpd.conf
}
