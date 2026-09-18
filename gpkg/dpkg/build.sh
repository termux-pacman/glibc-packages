TERMUX_PKG_HOMEPAGE=https://packages.debian.org/dpkg
TERMUX_PKG_DESCRIPTION="Debian package management system"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="1.22.6"
TERMUX_PKG_REVISION=1
# old tarball are removed in https://mirrors.kernel.org/debian/pool/main/d/dpkg/dpkg_${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SRCURL=git+https://salsa.debian.org/dpkg-team/dpkg.git
TERMUX_PKG_GIT_BRANCH="${TERMUX_PKG_VERSION}"
TERMUX_PKG_AUTO_UPDATE=false
TERMUX_PKG_DEPENDS="bzip2, coreutils, diffutils, gzip, less, libbz2-glibc, liblzma-glibc, libmd-glibc,  tar, xz-utils, zlib-glibc, zstd"
# libmd-glibc,
TERMUX_PKG_ANTI_BUILD_DEPENDS="clang"
TERMUX_PKG_BREAKS="dpkg-dev"
TERMUX_PKG_REPLACES="dpkg-dev"
# TERMUX_PKG_ESSENTIAL=true

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_lib_selinux_setexecfilecon=no
--disable-dselect
--disable-largefile
--disable-shared
dpkg_cv_c99_snprintf=yes
HAVE_SETEXECFILECON_FALSE=#
--build=$TERMUX_HOST_PLATFORM
--host=${TERMUX_ARCH}-linux
--without-selinux
DPKG_PAGER=less
"

TERMUX_PKG_RM_AFTER_INSTALL="
bin/dpkg-architecture
bin/dpkg-buildflags
bin/dpkg-buildpackage
bin/dpkg-checkbuilddeps
bin/dpkg-distaddfile
bin/dpkg-genbuildinfo
bin/dpkg-genchanges
bin/dpkg-gencontrol
bin/dpkg-gensymbols
bin/dpkg-maintscript-helper
bin/dpkg-mergechangelogs
bin/dpkg-name
bin/dpkg-parsechangelog
bin/dpkg-scansources
bin/dpkg-shlibdeps
bin/dpkg-source
bin/dpkg-statoverride
bin/dpkg-vendor
include
lib
share/dpkg
share/man/man1/dpkg-architecture.1
share/man/man1/dpkg-buildflags.1
share/man/man1/dpkg-buildpackage.1
share/man/man1/dpkg-checkbuilddeps.1
share/man/man1/dpkg-distaddfile.1
share/man/man1/dpkg-genbuildinfo.1
share/man/man1/dpkg-genchanges.1
share/man/man1/dpkg-gencontrol.1
share/man/man1/dpkg-gensymbols.1
share/man/man1/dpkg-maintscript-helper.1
share/man/man1/dpkg-mergechangelogs.1
share/man/man1/dpkg-name.1
share/man/man1/dpkg-parsechangelog.1
share/man/man1/dpkg-scansources.1
share/man/man1/dpkg-shlibdeps.1
share/man/man1/dpkg-source.1
share/man/man1/dpkg-statoverride.1
share/man/man1/dpkg-vendor.1
share/man/man3
share/man/man5
share/polkit-1
"
TERMUX_PKG_RM_AFTER_INSTALL=

termux_step_pre_configure() {
	bash autogen
	# change arm64 to aarch64
	patch -p1 -i "${TERMUX_PKG_BUILDER_DIR}"/configure.diff
	perl -p -i -e "s/TERMUX_ARCH/$TERMUX_ARCH/" $TERMUX_PKG_SRCDIR/configure
	sed -i 's/$req_vars = \$arch_vars.$varname./if ($varname eq "DEB_HOST_ARCH_CPU" or $varname eq "DEB_HOST_ARCH"){ print("'$TERMUX_ARCH'");exit; }; $req_vars = $arch_vars{$varname}/' scripts/dpkg-architecture.pl
}

1termux_step_make() {
	# ls $TERMUX_PKG_SRCDIR
	# bash $TERMUX_PKG_SRCDIR/build-aux/config.guess -h
	bash $TERMUX_PKG_SRCDIR/build-aux/config.guess 
	exit
}

termux_step_post_make_install() {
:
}

termux_step_post_massage() {

	 # --instdir=prefix wrapper for future simpler packets with no prefix folder shell 
	# if ! ${TERMUX_PKG_PROOT-false}; then
		# mkdir libexec
		# mv bin/dpkg libexec/
		# cp  $TERMUX_PKG_BUILDER_DIR/dpkg bin/
	# fi

	local var=var/lib/dpkg
	mkdir -p "$var/alternatives"
	mkdir -p "$var/info"
	mkdir -p "$var/triggers"
	mkdir -p "$var/updates"
}
