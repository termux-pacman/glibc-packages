#!/usr/bin/env bash

set -e

# adding configuration
PWD_SCRIPT=$(dirname "$(realpath "$0")")
. ${PWD_SCRIPT}/init.sh
. ${PWD_SCRIPT}/functions/error.sh
. ${PWD_SCRIPT}/functions/get_name.sh
. ${PWD_SCRIPT}/utils/get_deleted_pkgs.sh
export PATH="${PWD_SCRIPT}/tools:/usr/bin/core_perl:$PATH"

ARCH="x86_64"
PKGNAME="$1"

if [ "$ARCH" != "$(uname -m)" ]; then
	error "compilation is only possible on ${ARCH} architecture"
fi

if [ -z "$PKGNAME" ]; then
	error "no package name specified"
fi

if [ "$(id -u)" = "0" ]; then
	error "should not be run as root user"
fi

(
	if [ ! -d ${IMAGE_PATH_SOURCE} ]; then
		error "not found source '${IMAGE_PATH_SOURCE}'"
	fi
	cd ${IMAGE_PATH_SOURCE}

	if [ ! -d $PKGNAME ]; then
		error "not found $PKGNAME"
	fi
	sudo chown $(id -u) $PKGNAME
	sudo chgrp $(id -g) $PKGNAME
	cd $PKGNAME
	sudo chown $(id -u) *
	sudo chgrp $(id -g) *

	# packages removal check
	get_deleted_pkgs

	# start building
	makepkg -s --noconfirm

	mv *.pkg.* ${IMAGE_PATH_BUILD}
)
