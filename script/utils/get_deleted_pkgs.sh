#!/usr/bin/env bash

get_deleted_pkgs() {
	if [ -d ${GPKG_DEV_DIR_BUILD}/PKGBUILDs ]; then
		local new_pkg_list=$(sudo -H -u ${GPKG_DEV_USER_NAME} bash -c "makepkg --packagelist")
		(
			chmod a+rwx ${GPKG_DEV_DIR_BUILD}/PKGBUILDs
			cd ${GPKG_DEV_DIR_BUILD}/PKGBUILDs
			if [ -f $PKGNAME ]; then
				mv $PKGNAME PKGBUILD
				chmod a+rwx PKGBUILD
				for i in $(sudo -H -u ${GPKG_DEV_USER_NAME} bash -c "makepkg --packagelist"); do
					local delete=true
					local pkgpart=$(get_name $(basename $i))
					for j in $new_pkg_list; do
						if [ $pkgpart = $(get_name $(basename $j)) ]; then
							local delete=false
							break
						fi
					done
					if $delete; then
						echo "$pkgpart" >> ${GPKG_DEV_DIR_BUILD}/${GPKG_DEV_FILE_DELETING}
					fi
				done
				mv PKGBUILD $PKGNAME
			fi
		)
	fi
}
