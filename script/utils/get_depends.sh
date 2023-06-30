#!/usr/bin/env bash

get_depends() {
	local GPKG_DEV_REPO_URL="${GPKG_DEV_SERVER_URL}/gpkg-dev/${ARCH}"
	if [ -f DEPENDS ]; then
		if [ ! -f /mnt/pkgs.json ]; then
			curl "${GPKG_DEV_REPO_URL}/gpkg-dev.json" -o "${GPKG_DEV_REPO_JSON}"
		fi
		for i in $(cat DEPENDS); do
			echo "Installing '$i'"
			local FILENAME=$(cat ${GPKG_DEV_REPO_JSON} | jq -r '."'$i'"."FILENAME"')
			if [ "$FILENAME" = "null" ]; then
				error "package '$i' not found"
			elif [ -f /mnt/${FILENAME} ]; then
				echo "Skip installing '$i'"
				continue
			fi
			curl "${GPKG_DEV_REPO_URL}/${FILENAME}" -o /mnt/${FILENAME}
			if [ "$i" = "glibc" ]; then
				tar xJf /mnt/${FILENAME} -C / data/data/com.termux/files/usr/glibc/lib
			elif [ "$i" = "binutils-glibc" ]; then
				tar xJf /mnt/${FILENAME} -C / data/data/com.termux/files/usr/glibc/lib
				tar xJf /mnt/${FILENAME} -C / data/data/com.termux/files/usr/glibc/bin
			else
				tar xJf /mnt/${FILENAME} -C /
			fi
			if [ -d ${GLIBC_PREFIX}/lib64 ]; then
				mv ${GLIBC_PREFIX}/lib64/* ${GLIBC_PREFIX}/lib
				rm -fr ${GLIBC_PREFIX}/lib64
			fi
		done
	fi
}
