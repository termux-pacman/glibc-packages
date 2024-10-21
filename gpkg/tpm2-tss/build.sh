TERMUX_PKG_HOMEPAGE=https://github.com/tpm2-software/tpm2-tss
TERMUX_PKG_DESCRIPTION="Implementation of the TCG Trusted Platform Module 2.0 Software Stack (TSS2)"
TERMUX_PKG_LICENSE="BSD"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=4.1.3
TERMUX_PKG_SRCURL=https://github.com/tpm2-software/tpm2-tss/releases/download/${TERMUX_PKG_VERSION}/tpm2-tss-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=37f1580200ab78305d1fc872d89241aaee0c93cbe85bc559bf332737a60d3be8
TERMUX_PKG_DEPENDS="libcurl-glibc, json-c-glibc, openssl-glibc"
TERMUX_PKG_BUILD_DEPENDS="libtpms-glibc, doxygen-glibc, cmocka-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--with-udevrulesprefix=60-
--enable-unit
"
