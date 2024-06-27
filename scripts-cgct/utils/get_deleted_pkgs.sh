#!/usr/bin/env bash

get_deleted_pkgs() {
	if [ -d ${IMAGE_PATH_BUILD}/PKGBUILDs ]; then
		local new_pkg_list=$(makepkg --packagelist)
		(
			cd ${IMAGE_PATH_BUILD}/PKGBUILDs
			if [ -f $PKGNAME ]; then
				mv $PKGNAME PKGBUILD
				for i in $(makepkg --packagelist); do
					local delete=true
					local pkgpart=$(get_name ${i##*/})
					for j in $new_pkg_list; do
						if [ $pkgpart = $(get_name ${j##*/}) ]; then
							local delete=false
							break
						fi
					done
					if $delete; then
						echo "$pkgpart" >> ${IMAGE_PATH_BUILD}/${CGCT_FILE_DELETING}
					fi
				done
				mv PKGBUILD $PKGNAME
			fi
		)
	fi
}
