TERMUX_PKG_HOMEPAGE="https://tiswww.case.edu/php/chet/readline/rltop.html"
TERMUX_PKG_DESCRIPTION="Library that allow users to edit command lines as they are typed in"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_DEPENDS="ncurses-glibc"
_MAIN_VERSION=8.3
_PATCH_VERSION=3
TERMUX_PKG_VERSION=$_MAIN_VERSION.$_PATCH_VERSION
TERMUX_PKG_SRCURL=https://ftp.gnu.org/gnu/readline/readline-${_MAIN_VERSION}.tar.gz
TERMUX_PKG_SHA256=fe5383204467828cd495ee8d1d3c037a7eba1389c22bc6a041f627976f9061cc
TERMUX_PKG_CONFFILES="glibc/etc/inputrc"
TERMUX_PKG_EXTRA_MAKE_ARGS="SHLIB_LIBS=-lncurses"

termux_step_pre_configure() {
	declare -A PATCH_CHECKSUMS

	PATCH_CHECKSUMS[001]=21f0a03106dbe697337cd25c70eb0edbaa2bdb6d595b45f83285cdd35bac84de
	PATCH_CHECKSUMS[002]=e27364396ba9f6debf7cbaaf1a669e2b2854241ae07f7eca74ca8a8ba0c97472
	PATCH_CHECKSUMS[003]=72dee13601ce38f6746eb15239999a7c56f8e1ff5eb1ec8153a1f213e4acdb29

	for PATCH_NUM in $(seq -f '%03g' ${_PATCH_VERSION}); do
		PATCHFILE=$TERMUX_PKG_CACHEDIR/readline_patch_${PATCH_NUM}.patch
		termux_download \
			"https://ftp.gnu.org/gnu/readline/readline-$_MAIN_VERSION-patches/readline${_MAIN_VERSION/./}-$PATCH_NUM" \
			$PATCHFILE \
			${PATCH_CHECKSUMS[$PATCH_NUM]}
		patch -p0 -i $PATCHFILE
	done

	sed -i 's|-Wl,-rpath,$(libdir) ||g' support/shobj-conf
}

termux_step_post_make_install() {
	mkdir -p $TERMUX_PREFIX/lib/pkgconfig
	cp readline.pc $TERMUX_PREFIX/lib/pkgconfig/

	mkdir -p $TERMUX_PREFIX/etc
	cp $TERMUX_PKG_BUILDER_DIR/inputrc $TERMUX_PREFIX/etc/
}
