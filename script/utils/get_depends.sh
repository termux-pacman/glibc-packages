#!/usr/bin/env bash

get_depends() {
	local GPKG_DEV_REPO_URL="${GPKG_DEV_SERVER_URL}/gpkg-dev/${ARCH}"
	if [ -f DEPENDS ]; then
		if [ ! -f /mnt/pkgs.json ]; then
			curl "${GPKG_DEV_REPO_URL}/gpkg-dev.json" -o "${GPKG_DEV_REPO_JSON}"
		fi
		for i in $(cat DEPENDS); do
			if $(echo "$1" | grep -q "'$i'"); then
				continue
			fi
			if [ -z "$1" ]; then
				echo "Installing '$i'"
			else
				echo "Installing '$i' on request $1"
			fi
			local FILENAME=$(cat ${GPKG_DEV_REPO_JSON} | jq -r '."'$i'"."FILENAME"')
			if [ "$FILENAME" = "null" ]; then
				error "package '$i' not found"
			fi
			local BASE=$(cat ${GPKG_DEV_REPO_JSON} | jq -r '."'$i'"."BASE"')
			(
				cd "${GPKG_DEV_DIR_SOURCE}/$(echo $BASE | sed 's/-glibc//')"
				if [ -z "$1" ]; then
					get_depends "'$i'"
				else
					get_depends "$1.'$i'"
				fi
			)
			if [ -f /mnt/${FILENAME} ]; then
				echo "Skip installing '$i'"
				continue
			fi
			curl "${GPKG_DEV_REPO_URL}/${FILENAME}" -o /mnt/${FILENAME}
			if [ "$i" = "glibc" ]; then
				sudo -H -u ${GPKG_DEV_USER_NAME} tar xJf /mnt/${FILENAME} -C / data/data/com.termux/files/usr/glibc/lib
			elif [ "$i" = "binutils-glibc" ]; then
				sudo -H -u ${GPKG_DEV_USER_NAME} tar xJf /mnt/${FILENAME} -C / data/data/com.termux/files/usr/glibc/lib
				sudo -H -u ${GPKG_DEV_USER_NAME} tar xJf /mnt/${FILENAME} -C / data/data/com.termux/files/usr/glibc/bin
			else
				sudo -H -u ${GPKG_DEV_USER_NAME} tar xJf /mnt/${FILENAME} -C / data
			fi
		done
	fi
}
