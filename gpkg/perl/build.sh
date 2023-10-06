TERMUX_PKG_HOMEPAGE=https://www.perl.org/
TERMUX_PKG_DESCRIPTION="Capable, feature-rich programming language"
TERMUX_PKG_LICENSE="Artistic-License-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=5.38.0
_MAJOR_VERSION="${TERMUX_PKG_VERSION%.*}"
TERMUX_PKG_SRCURL=https://www.cpan.org/src/5.0/perl-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=eca551caec3bc549a4e590c0015003790bdd1a604ffe19cc78ee631d51f7072e
TERMUX_PKG_DEPENDS="gdbm-glibc, libdb-glibc, glibc, libxcrypt-glibc"
TERMUX_MAKE_PROCESSES=1
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_RM_AFTER_INSTALL="glibc/bin/perl${TERMUX_PKG_VERSION}"

termux_step_configure() {
	./Configure \
		-Dtargetarch=$TERMUX_HOST_PLATFORM \
		-Dcc=$CC -Dcpp=$CXX -Dranlib=$RANLIB \
		-Dld=$CXX -Dar=$AR -Dnm=$NM \
		-Dlocincpth=$TERMUX_PREFIX/include \
		-Dloclibpth=$TERMUX_PREFIX/lib \
		-Dglibpth=$TERMUX_PREFIX/lib \
		-Dxlibpth=$TERMUX_PREFIX/lib \
		-Dplibpth=$TERMUX_PREFIX/lib \
		-Dlibpth=$TERMUX_PREFIX/lib \
		-Dsh=$TERMUX_PREFIX/bin/sh \
		-des -Duseshrplib -Dusethreads -Doptimize="${CFLAGS}" \
		-Dprefix=$TERMUX_PREFIX -Dvendorprefix=$TERMUX_PREFIX \
		-Dprivlib=$TERMUX_PREFIX/share/perl5 \
		-Darchlib=$TERMUX_PREFIX/lib/perl5/$_MAJOR_VERSION \
		-Dsitelib=$TERMUX_PREFIX/share/perl5 \
		-Dsitearch=$TERMUX_PREFIX/lib/perl5/$_MAJOR_VERSION \
		-Dvendorlib=$TERMUX_PREFIX/share/perl5 \
		-Dvendorarch=$TERMUX_PREFIX/lib/perl5/$_MAJOR_VERSION \
		-Dscriptdir=$TERMUX_PREFIX/bin \
		-Dsitescript=$TERMUX_PREFIX/bin \
		-Dvendorscript=$TERMUX_PREFIX/bin \
		-Dinc_version_list=none \
		-Dman1ext=1perl -Dman3ext=3perl \
		-Dosname=linux -Dmyuname="termux" -Dmyhostname="termux" \
		-Dlddlflags="-shared ${LDFLAGS}" -Dldflags="${LDFLAGS}" \
		-Dcf_time="`date -u --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}"`"
}

termux_step_post_make_install() {
	(
		cd $TERMUX_PREFIX/share/man/man1
		rm perlbug.1perl
		ln -s perlthanks.1perl perlbug.1perl
	)

	sed -e '/^man1ext=/ s/1perl/1p/' -e '/^man3ext=/ s/3perl/3pm/' \
		-e "/^cf_email=/ s/'.*'/''/" \
		-e "/^perladmin=/ s/'.*'/''/" \
		-i "${TERMUX_PREFIX}/lib/perl5/$_MAJOR_VERSION/Config_heavy.pl"

	sed -e '/(makepl_arg =>/   s/""/"INSTALLDIRS=site"/' \
		-e '/(mbuildpl_arg =>/ s/""/"installdirs=site"/' \
		-i "${TERMUX_PREFIX}/share/perl5/CPAN/FirstTime.pm"
}
