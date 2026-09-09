TERMUX_PKG_HOMEPAGE=https://github.com/tpm2-software/tpm2-tss
TERMUX_PKG_DESCRIPTION="Implementation of the TCG Trusted Platform Module 2.0 Software Stack (TSS2)"
TERMUX_PKG_LICENSE="BSD"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=4.2.0
TERMUX_PKG_SRCURL=https://github.com/tpm2-software/tpm2-tss/releases/download/${TERMUX_PKG_VERSION}/tpm2-tss-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=b53f0c5c8c4ce17f05701a410ca9688f725ca380c9bc4640eacd0eadb1fea124
TERMUX_PKG_DEPENDS="libcurl-glibc, json-c-glibc, openssl-glibc"
TERMUX_PKG_BUILD_DEPENDS="libtpms-glibc, doxygen-glibc, cmocka-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--with-udevrulesprefix=60-
--enable-unit
"
