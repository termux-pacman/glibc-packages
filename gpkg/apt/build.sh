TERMUX_PKG_HOMEPAGE=https://packages.debian.org/apt
TERMUX_PKG_DESCRIPTION="Front-end for the dpkg package manager"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="2.8.1"
TERMUX_PKG_REVISION=1
# old tarball are removed in https://deb.debian.org/debian/pool/main/a/apt/apt_${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SRCURL=https://salsa.debian.org/apt-team/apt/-/archive/${TERMUX_PKG_VERSION}/apt-${TERMUX_PKG_VERSION}.tar.bz2
TERMUX_PKG_SHA256=87ca18392c10822a133b738118505f7d04e0b31ba1122bf5d32911311cb2dc7e
# apt-key requires utilities from coreutils, findutils, gpgv, grep, sed.
# TERMUX_PKG_DEPENDS="coreutils, dpkg, findutils, gpgv, grep, libbz2, libc++, libiconv, libgcrypt, libgnutls, liblz4, liblzma, sed, xxhash, zlib, zstd"
TERMUX_PKG_DEPENDS="coreutils-glibc, dpkg-glibc, findutils, gpgv, grep, libbz2-glibc, libc++, libiconv-glibc, libgcrypt-glibc, libgnutls-glibc, liblz4-glibc, liblzma-glibc, sed, xxhash-glibc, zlib-glibc, zstd-glibc"
# TERMUX_PKG_DEPENDS="libbz2-glibc, zlib-glibc"
# termux-licenses, termux-keyring
TERMUX_PKG_BUILD_DEPENDS="docbook-xsl, libdb-glibc"
# TERMUX_PKG_CONFLICTS="apt-transport-https, libapt-pkg, unstable-repo, game-repo, science-repo"
# TERMUX_PKG_REPLACES="apt-transport-https, libapt-pkg, unstable-repo, game-repo, science-repo"
# TERMUX_PKG_PROVIDES="unstable-repo, game-repo, science-repo"
TERMUX_PKG_SUGGESTS="proot"
# TERMUX_PKG_ESSENTIAL=true

TERMUX_PKG_CONFFILES="
etc/apt/sources.list
"

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DPERL_EXECUTABLE=$(command -v perl)
-DCOMMON_ARCH=$TERMUX_ARCH
-DUSE_NLS=OFF
-DWITH_DOC=OFF
-DWITH_DOC_MANPAGES=OFF
-DWITH_TESTS=OFF
-DDPKG_DATADIR=$TERMUX_PREFIX/share/dpkg
"
# -DCMAKE_INSTALL_FULL_LOCALSTATEDIR=$TERMUX_PREFIX
# -DCACHE_DIR=${TERMUX_CACHE_DIR}/apt

# ubuntu uses instead $PREFIX/lib instead of $PREFIX/libexec to
# "Work around bug in GNUInstallDirs" (from apt 1.4.8 CMakeLists.txt).
# Archlinux uses $PREFIX/libexec though, so let's force libexec->lib to
# get same build result on ubuntu and archlinux.
TERMUX_PKG_EXTRA_CONFIGURE_ARGS+="-DCMAKE_INSTALL_LIBEXECDIR=lib"

TERMUX_PKG_RM_AFTER_INSTALL="
bin/apt-cdrom
bin/apt-extracttemplates
bin/apt-sortpkgs
etc/apt/apt.conf.d
lib/apt/methods/cdrom
lib/apt/methods/mirror*
lib/apt/methods/rred
lib/apt/planners/
lib/apt/solvers/
lib/dpkg/
share/man/man1/apt-extracttemplates.1
share/man/man1/apt-sortpkgs.1
share/man/man1/apt-transport-mirror.1
share/man/man8/apt-cdrom.8
"

# echo apt;exit

termux_step_pre_configure() {
	# echo what;exit
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $TERMUX_PREFIX.
	if $TERMUX_ON_DEVICE_BUILD && ! ${TERMUX_SAFE_BUILD-false}; then
		termux_error_exit "Package '$TERMUX_PKG_NAME' require  --safe for on-device builds"
	fi

	# Fix i686 builds.
	CXXFLAGS+=" -Wno-c++11-narrowing"

	# for manpage build
	local docbook_xsl_version=$(. $TERMUX_SCRIPTDIR/packages/docbook-xsl/build.sh; echo $TERMUX_PKG_VERSION)
	TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" -DDOCBOOK_XSL=$TERMUX_PREFIX_CLASSICAL/share/xml/docbook/xsl-stylesheets-$docbook_xsl_version-nons"
}

termux_step_post_configure() {
	sed -i.old '1s;^;#include <cstdint>\n;' $TERMUX_PKG_SRCDIR/apt-pkg/contrib/strutl.cc
}

termux_step_post_make_install() {
	:
	# local target=$TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/etc/apt
}

termux_step_post_massage() {
	local target=etc/apt
	mkdir -p $target

	# no recommend 
	local_replace_prefix $TERMUX_PKG_BUILDER_DIR/apt.conf.in  $target/apt.conf

	# cert file read error. the rest  is not needed prefix already handles paths
	if ! ${TERMUX_PKG_PROOT-false}; then
		mkdir $target/apt.conf.d
		local_replace_prefix $TERMUX_PKG_BUILDER_DIR/root.conf.in  $target/apt.conf.d/root.conf
	fi

	mkdir $target/sources.list.d 
	cp $TERMUX_PKG_BUILDER_DIR/glibc.list $target/sources.list.d/

	mkdir $target/trusted.gpg.d 
	cp $TERMUX_SCRIPTDIR/packages/termux-keyring/termux-autobuilds.gpg $target/trusted.gpg.d/
}

local_replace_prefix() {
	sed -e "s|@TERMUX_PREFIX@|${TERMUX_PREFIX}|g" \
		-e "s|@TERMUX_CACHE_DIR@|${TERMUX_CACHE_DIR}|g" \
	$1 > $2
}
