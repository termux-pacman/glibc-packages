TERMUX_PKG_HOMEPAGE=https://code.videolan.org/videolan/dav1d/
TERMUX_PKG_DESCRIPTION="AV1 cross-platform decoder focused on speed and correctness"
TERMUX_PKG_LICENSE="BSD 2-Clause"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="1.5.3"
TERMUX_PKG_SRCURL=https://code.videolan.org/videolan/dav1d/-/archive/${TERMUX_PKG_VERSION}/dav1d-${TERMUX_PKG_VERSION}.tar.bz2
TERMUX_PKG_SHA256=e099f53253f6c247580c554d53a13f1040638f2066edc3c740e4c2f15174ce22
TERMUX_PKG_DEPENDS="glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Denable_tools=true
-Denable_tests=true
"
