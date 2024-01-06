TERMUX_PKG_HOMEPAGE="https://p11-glue.github.io/p11-glue/p11-kit.html"
TERMUX_PKG_DESCRIPTION="Provides a way to load and enumerate PKCS#11 modules"
TERMUX_PKG_LICENSE="BSD 3-Clause"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=0.25.3
TERMUX_PKG_SRCURL="https://github.com/p11-glue/p11-kit/releases/download/$TERMUX_PKG_VERSION/p11-kit-$TERMUX_PKG_VERSION.tar.xz"
TERMUX_PKG_SHA256=d8ddce1bb7e898986f9d250ccae7c09ce14d82f1009046d202a0eb1b428b2adc
TERMUX_PKG_DEPENDS="libffi-glibc, libtasn1-glibc"
TERMUX_PKG_BUILD_DEPENDS="bash-completion-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
--with-trust-paths=$TERMUX_PREFIX/etc/ca-certificates/trust-source:$TERMUX_PREFIX/share/ca-certificates/trust-source
"
