# set -x
TERMUX_PKG_DESCRIPTION='Debian Sid  repo in the same shell as bionic with no P root or pre download except dapt update. source $DATA/debian/bashrc and use dapt/dpkgx instead of apt/dpkg'
TERMUX_PKG_LICENSE="WTFPL"
TERMUX_PKG_VERSION="0"
TERMUX_PKG_SUGGESTS="dpkgx, glibc, proot, proot-distro"
TERMUX_PKG_PLATFORM_INDEPENDENT=true

termux_step_configure() { :; }
termux_step_make() { :; }

termux_step_make_install() {
	target=$TERMUX_PKG_MASSAGEDIR/$TERMUX_BASE_DIR/../debian
	mkdir -p $target
	cp $TERMUX_PKG_BUILDER_DIR/* $target
}

termux_step_install_license() { :; }
termux_step_extract_into_massagedir() { :; }
termux_step_massage() { 
mkdir -p "$TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX_CLASSICAL"
}
