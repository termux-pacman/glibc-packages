TERMUX_PKG_HOMEPAGE=https://gitlab.freedesktop.org/glvnd/libglvnd
TERMUX_PKG_DESCRIPTION="The GL Vendor-Neutral Dispatch library"
TERMUX_PKG_LICENSE="custom"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="1.7.0"
TERMUX_PKG_SRCURL=https://gitlab.freedesktop.org/glvnd/libglvnd/-/archive/v${TERMUX_PKG_VERSION}/libglvnd-v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=2b6e15b06aafb4c0b6e2348124808cbd9b291c647299eaaba2e3202f51ff2f3d
TERMUX_PKG_DEPENDS="libxext-glibc"
TERMUX_PKG_BUILD_DEPENDS="xorgproto-glibc"
# Currently there is no mesa-glibc
#TERMUX_PKG_RECOMMENDS="mesa-glibc"

termux_step_install_license() {
	install -Dm600 -t $TERMUX_PREFIX/share/doc/$TERMUX_PKG_NAME \
		$TERMUX_PKG_BUILDER_DIR/LICENSE
}

termux_step_post_massage() {
	# A bunch of programs in the wild assume that the name of OpenGL shared
	# library is `libGL.so.1` and try to dlopen(3) it. In fact `sdl2` does
	# this. Also `libEGL.so` and some others need SOVERSION suffix to avoid
	# conflict with system ones. So let's check if SONAME is properly set.
	local n
	for n in GL EGL GLESv1_CM GLESv2; do
		local f="glibc/lib/lib${n}.so"
		if [ ! -e "${f}" ]; then
			termux_error_exit "Shared library ${f} does not exist."
		fi
		if ! readelf -d "${f}" | grep -q '(SONAME).*\[lib'"${n}"'\.so\.'; then
			termux_error_exit "SONAME for ${f} is not properly set."
		fi
	done
}
