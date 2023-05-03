#!/usr/bin/env bash

set -e

# adding configuration
PWD_SCRIPT=$(dirname "$(realpath "$0")")
. ${PWD_SCRIPT}/init.sh
. ${PWD_SCRIPT}/set_flags.sh
. ${PWD_SCRIPT}/functions/get_name.sh
export PATH="${PWD_SCRIPT}/tools:$PATH"

pkgname="$1"

check_not_termux

if [ -z "$pkgname" ]; then
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

	if [ ! -d $pkgname ]; then
		error "not found $pkgname"
	fi
	chmod a+rwx $pkgname
	cd $pkgname
	chmod a+rwx *

	# packages removal check
	new_pkg_list=$(sudo -H -u ${GPKG_DEV_USER_NAME} bash -c "makepkg --packagelist")
	(
		chmod a+rwx ${GPKG_DEV_DIR_BUILD}/PKGBUILDs
		cd ${GPKG_DEV_DIR_BUILD}/PKGBUILDs
		mv $pkgname PKGBUILD
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
		mv PKGBUILD $pkgname
	)

	# start building
	if [ ! -f src.tar.gz ]; then
		sudo -Es -H -u ${GPKG_DEV_USER_NAME} bash -c "makepkg -o"
	else
		sudo -H -u ${GPKG_DEV_USER_NAME} bash -c "tar xf src.tar.gz"
	fi
	sudo -Es -H -u ${GPKG_DEV_USER_NAME} bash -c '(timeout --preserve-status 330m makepkg -e --noarchive && ([ "$?" = "0" ] && makepkg -R)) || ([ "$?" = "143" ] && true)'

	if $(ls *.pkg.* &> /dev/null); then
		mv *.pkg.* ${GPKG_DEV_DIR_BUILD}
		echo " ${pkgname} " >> ${GPKG_DEV_DIR_BUILD}/gpkg-dev-done.txt
	else
		sudo -H -u ${GPKG_DEV_USER_NAME} bash -c "tar cf src.tar.gz src"
		mv src.tar.gz ${GPKG_DEV_DIR_BUILD}
		echo "${pkgname}" > ${GPKG_DEV_DIR_BUILD}/gpkg-dev-continue.txt
	fi
)
