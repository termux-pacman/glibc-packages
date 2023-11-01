TERMUX_PKG_HOMEPAGE=https://src.fedoraproject.org/rpms/ca-certificates
TERMUX_PKG_DESCRIPTION="Common CA certificates"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
_DATE=2023-08-22
TERMUX_PKG_VERSION=${_DATE//-/.}
TERMUX_PKG_SRCURL=https://curl.se/ca/cacert-${_DATE}.pem
TERMUX_PKG_SHA256=23c2469e2a568362a62eecf1b49ed90a15621e6fa30e29947ded3436422de9b9
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
