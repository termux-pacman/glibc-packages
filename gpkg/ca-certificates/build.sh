TERMUX_PKG_HOMEPAGE=https://src.fedoraproject.org/rpms/ca-certificates
TERMUX_PKG_DESCRIPTION="Common CA certificates"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
_DATE=2023-12-12
TERMUX_PKG_VERSION=${_DATE//-/.}
TERMUX_PKG_SRCURL=https://curl.se/ca/cacert-${_DATE}.pem
TERMUX_PKG_SHA256=ccbdfc2fe1a0d7bbbb9cc15710271acf1bb1afe4c8f1725fe95c4c7733fcbe5a
TERMUX_PKG_SKIP_SRC_EXTRACT=true
TERMUX_PKG_PLATFORM_INDEPENDENT=true

termux_step_make_install() {
	install -d ${TERMUX_PREFIX}/etc/{ca-certificates,ssl/certs}/

	termux_download $TERMUX_PKG_SRCURL \
		${TERMUX_PREFIX}/etc/ca-certificates/cacert.pem.new \
		$TERMUX_PKG_SHA256
	rm -f ${TERMUX_PREFIX}/etc/ca-certificates/cacert.pem
	mv ${TERMUX_PREFIX}/etc/ca-certificates/cacert.pem.new ${TERMUX_PREFIX}/etc/ca-certificates/cacert.pem

	ln -sfr ${TERMUX_PREFIX}/etc/ca-certificates/cacert.pem ${TERMUX_PREFIX}/etc/ssl/cert.pem
	ln -sfr ${TERMUX_PREFIX}/etc/ca-certificates/cacert.pem ${TERMUX_PREFIX}/etc/ssl/certs/ca-certificates.crt
	ln -sfr ${TERMUX_PREFIX}/etc/ca-certificates/cacert.pem ${TERMUX_PREFIX}/etc/ssl/certs/ca-bundle.crt
}
