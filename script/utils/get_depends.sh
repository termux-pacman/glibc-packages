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
			tar xJf /mnt/${FILENAME} -C /
		done
	fi
}
