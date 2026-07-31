TERMUX_PKG_HOMEPAGE=https://web.mit.edu/kerberos
TERMUX_PKG_DESCRIPTION="The Kerberos network authentication system"
TERMUX_PKG_LICENSE="custom"
TERMUX_PKG_LICENSE_FILE="../NOTICE"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.22.2
TERMUX_PKG_SRCURL=https://fossies.org/linux/misc/krb5-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=3243ffbc8ea4d4ac22ddc7dd2a1dc54c57874c40648b60ff97009763554eaf13
TERMUX_PKG_DEPENDS="e2fsprogs-glibc, libverto-glibc"
TERMUX_PKG_CONFFILES="glibc/etc/krb5.conf glibc/var/krb5kdc/kdc.conf"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
--sbindir=$TERMUX_PREFIX/bin
--enable-shared
--with-system-et
--with-system-ss
--without-tcl
--without-ldap
--enable-dns-for-realm
--with-system-verto
DEFCCNAME=$TERMUX_PREFIX/tmp/krb5cc_%{uid}
DEFKTNAME=$TERMUX_PREFIX/etc/krb5.keytab
DEFCKTNAME=$TERMUX_PREFIX/var/krb5/user/%{euid}/client.keytab
"
#--with-ldap

termux_step_post_get_source() {
	if [ "$TERMUX_ON_DEVICE_BUILD" = "false" ]; then
		# Due to incorrect library routing in CGCT, need to make sure
		# that the old krb5 libraries are not in `${TERMUX_PREFIX}/lib`.
		# TODO: fix library routing in CGCT
		rm -f $TERMUX_PREFIX/lib/lib{gss{api_krb5,rpc},k5crypto,kadm5clnt{,_mit},kadm5srv{,_mit},kdb5,krad,krb5{,support}}*
	fi

	TERMUX_PKG_SRCDIR+="/src"
}

termux_step_pre_configure() {
	export WARN_CFLAGS=""
}

termux_step_post_make_install() {
	# Enable logging to STDERR by default
	echo -e "\tdefault = STDERR" >> $TERMUX_PKG_SRCDIR/config-files/krb5.conf

	# Sample KDC config file
	install -dm 700 $TERMUX_PREFIX/var/krb5kdc
	install -pm 600 $TERMUX_PKG_SRCDIR/config-files/kdc.conf $TERMUX_PREFIX/var/krb5kdc/kdc.conf

	# Default configuration file
	install -pm 600 $TERMUX_PKG_SRCDIR/config-files/krb5.conf $TERMUX_PREFIX/etc/krb5.conf

	install -dm 700 $TERMUX_PREFIX/share/aclocal
	install -m 600 $TERMUX_PKG_SRCDIR/util/ac_check_krb5.m4 $TERMUX_PREFIX/share/aclocal
}
