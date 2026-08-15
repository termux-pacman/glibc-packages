TERMUX_PKG_HOMEPAGE=https://www.rust-lang.org/
TERMUX_PKG_DESCRIPTION="Rust systems programming language compiler and standard library"
TERMUX_PKG_LICENSE="Apache-2.0, MIT"
TERMUX_PKG_LICENSE_FILE="COPYRIGHT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.82.0
TERMUX_PKG_SKIP_SRC_EXTRACT=true
TERMUX_PKG_DEPENDS="glibc, gcc-libs-glibc, libcurl-glibc, libssh2-glibc, openssl-glibc, zlib-glibc"
TERMUX_PKG_NO_STATICSPLIT=true

termux_step_make_install() {
	local _rust_host=""
	case "$TERMUX_ARCH" in
		aarch64) _rust_host="aarch64-unknown-linux-gnu" ;;
		arm)     _rust_host="armv7-unknown-linux-gnueabihf" ;;
		x86_64)  _rust_host="x86_64-unknown-linux-gnu" ;;
		i686)    _rust_host="i686-unknown-linux-gnu" ;;
	esac

	local _rust_url="https://static.rust-lang.org/dist"
	local _sha256

	# Download and install rust-std (target standard library)
	termux_download \
		"${_rust_url}/rust-std-${TERMUX_PKG_VERSION}-${_rust_host}.tar.gz" \
		"${TERMUX_PKG_CACHEDIR}/rust-std-${TERMUX_PKG_VERSION}-${_rust_host}.tar.gz" \
		"SKIP_CHECKSUM"
	tar -xf "${TERMUX_PKG_CACHEDIR}/rust-std-${TERMUX_PKG_VERSION}-${_rust_host}.tar.gz" -C "${TERMUX_PKG_BUILDDIR}"
	(
		cd "${TERMUX_PKG_BUILDDIR}/rust-std-${TERMUX_PKG_VERSION}-${_rust_host}"
		./install.sh \
			--prefix="$TERMUX_PREFIX" \
			--sysconfdir="$TERMUX_PREFIX/etc" \
			--datadir="$TERMUX_PREFIX/share" \
			--docdir="$TERMUX_PREFIX/share/doc/rust" \
			--mandir="$TERMUX_PREFIX/share/man"
	)

	# Download and install rustc (compiler)
	termux_download \
		"${_rust_url}/rustc-${TERMUX_PKG_VERSION}-${_rust_host}.tar.gz" \
		"${TERMUX_PKG_CACHEDIR}/rustc-${TERMUX_PKG_VERSION}-${_rust_host}.tar.gz" \
		"SKIP_CHECKSUM"
	tar -xf "${TERMUX_PKG_CACHEDIR}/rustc-${TERMUX_PKG_VERSION}-${_rust_host}.tar.gz" -C "${TERMUX_PKG_BUILDDIR}"
	(
		cd "${TERMUX_PKG_BUILDDIR}/rustc-${TERMUX_PKG_VERSION}-${_rust_host}"
		./install.sh \
			--prefix="$TERMUX_PREFIX" \
			--sysconfdir="$TERMUX_PREFIX/etc" \
			--datadir="$TERMUX_PREFIX/share" \
			--docdir="$TERMUX_PREFIX/share/doc/rust" \
			--mandir="$TERMUX_PREFIX/share/man"
	)

	# Download and install cargo (package manager)
	termux_download \
		"${_rust_url}/cargo-${TERMUX_PKG_VERSION}-${_rust_host}.tar.gz" \
		"${TERMUX_PKG_CACHEDIR}/cargo-${TERMUX_PKG_VERSION}-${_rust_host}.tar.gz" \
		"SKIP_CHECKSUM"
	tar -xf "${TERMUX_PKG_CACHEDIR}/cargo-${TERMUX_PKG_VERSION}-${_rust_host}.tar.gz" -C "${TERMUX_PKG_BUILDDIR}"
	(
		cd "${TERMUX_PKG_BUILDDIR}/cargo-${TERMUX_PKG_VERSION}-${_rust_host}"
		./install.sh \
			--prefix="$TERMUX_PREFIX" \
			--sysconfdir="$TERMUX_PREFIX/etc" \
			--datadir="$TERMUX_PREFIX/share" \
			--docdir="$TERMUX_PREFIX/share/doc/rust" \
			--mandir="$TERMUX_PREFIX/share/man"
	)

	# Remove uninstall script
	rm -f "$TERMUX_PREFIX/lib/rustlib/install.log"
	rm -f "$TERMUX_PREFIX/lib/rustlib/manifest-*"
	rm -f "$TERMUX_PREFIX/lib/rustlib/uninstall.sh"
}
