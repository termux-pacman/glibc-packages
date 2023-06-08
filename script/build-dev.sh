#!/usr/bin/env bash

set -e

# adding configuration
PWD_SCRIPT=$(dirname "$(realpath "$0")")
ARCH="$1"
. ${PWD_SCRIPT}/init.sh
## checking and setting arch value
case $ARCH in
	aarch64|arm|x86_64|i686);;
	*) error "Error: wrong arch specified (support only aarch64, arm, x86_64 and i686)";;
esac
. ${PWD_SCRIPT}/set_makepkg.sh
. ${PWD_SCRIPT}/functions/get_name.sh
export PATH="${PWD_SCRIPT}/tools:$PATH"

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

	# packages removal check
	new_pkg_list=$(sudo -H -u ${GPKG_DEV_USER_NAME} bash -c "makepkg --packagelist")
	(
		chmod a+rwx ${GPKG_DEV_DIR_BUILD}/PKGBUILDs
		cd ${GPKG_DEV_DIR_BUILD}/PKGBUILDs
		mv $PKGNAME PKGBUILD
		chmod a+rwx PKGBUILD
		for i in $(sudo -H -u ${GPKG_DEV_USER_NAME} bash -c "makepkg --packagelist"); do
			delete=true
			pkgpart=$(get_name $(basename $i))
			for j in $new_pkg_list; do
				if [ $pkgpart = $(get_name $(basename $j)) ]; then
					delete=false
					break
				fi
			done
			if $delete; then
				echo "$pkgpart" >> ${GPKG_DEV_DIR_BUILD}/deleted_gpkg-dev_packages.txt
			fi
		done
		mv PKGBUILD $PKGNAME
	)

	# start building
	sudo -Es -H -u ${GPKG_DEV_USER_NAME} bash -c "makepkg"

	mv *.pkg.* ${GPKG_DEV_DIR_BUILD}
	echo " ${PKGNAME} " >> ${GPKG_DEV_DIR_BUILD}/gpkg-dev-done.txt
)
