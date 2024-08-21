TERMUX_PKG_HOMEPAGE=http://www.doxygen.org
TERMUX_PKG_DESCRIPTION="A documentation system for C++, C, Java, IDL and PHP"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="1.12.0"
TERMUX_PKG_SRCURL=https://github.com/doxygen/doxygen/archive/Release_${TERMUX_PKG_VERSION//./_}.tar.gz
TERMUX_PKG_SHA256=5ca35e1258020df5fe8b21c3656aed156c317def4a81b7fe52f452edc9f35768
TERMUX_PKG_DEPENDS="glibc, gcc-libs-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DDOC_INSTALL_DIR:PATH=share/doc/doxygen
-DPYTHON_EXECUTABLE:FILE=$(command -v python3)
"
# -Dbuild_wizard:BOOL=ON - at the moment we do not have qt

termux_step_post_make_install() {
	mkdir -p "$TERMUX_PREFIX"/share/man/man1
	cp "$TERMUX_PKG_SRCDIR"/doc/doxygen.1 "$TERMUX_PREFIX"/share/man/man1
}
