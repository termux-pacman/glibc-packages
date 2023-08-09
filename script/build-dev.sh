#!/usr/bin/env bash

set -e

# adding configuration
PWD_SCRIPT=$(dirname "$(realpath "$0")")
ARCH="$1"
. ${PWD_SCRIPT}/init.sh
. ${PWD_SCRIPT}/functions/error.sh
case $ARCH in
	aarch64|arm|x86_64|i686);;
	*) error "Error: wrong arch specified (support only aarch64, arm, x86_64 and i686)";;
esac
. ${PWD_SCRIPT}/functions/get_name.sh
. ${PWD_SCRIPT}/utils/set_makepkg.sh
. ${PWD_SCRIPT}/utils/set_data.sh
. ${PWD_SCRIPT}/utils/get_deleted_pkgs.sh
. ${PWD_SCRIPT}/utils/get_depends.sh
export PATH="${PWD_SCRIPT}/tools:/usr/bin/core_perl:$PATH"

PKGNAME="$2"

check_not_termux

if [ -z "$PKGNAME" ]; then
	error "no package name specified"
fi

if ! $(id ${GPKG_DEV_USER_NAME} &>/dev/null); then
	error "not found user ${GPKG_DEV_USER_NAME}"
fi

(
	if [ ! -d ${GPKG_DEV_DIR_SOURCE} ]; then
		error "not found source '${GPKG_DEV_DIR_SOURCE}'"
	fi
	cd ${GPKG_DEV_DIR_SOURCE}

	if [ ! -d $PKGNAME ]; then
		error "not found $PKGNAME"
	fi
	chmod a+rwx $PKGNAME
	cd $PKGNAME
	chmod a+rwx *

	arch_pkg=$(grep 'arch=(.*)' PKGBUILD | sed 's\arch=(\\; s\)\\; s\'"'"'\\g')

	if [ "$arch_pkg" = "any" ] || [ "$arch_pkg" = "$ARCH" ]; then
		# packages removal check
		get_deleted_pkgs

		# Installing dependencies
		get_depends

		# start building
		sudo -Es -H -u ${GPKG_DEV_USER_NAME} bash -c "makepkg"

		mv *.pkg.* ${GPKG_DEV_DIR_BUILD}
	fi

	echo "${PKGNAME}" >> ${GPKG_DEV_DIR_BUILD}/gpkg-dev-done.txt
)
