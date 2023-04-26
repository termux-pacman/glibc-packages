#!/usr/bin/bash

set -e

# adding configuration
. $(dirname "$(realpath "$0")")/init.sh

# value designations
arch="$1"
command="$@"

chech_not_termux

# checking and setting arch value
case $arch in
	aarch64|armv7h|x86_64|i686);;
	arm) arch="armv7h";;
	*) error "Error: wrong arch specified (support only aarch64, armv7h, x86_64 and i686)";;
esac

# checking dirs for existence
for i in $DIR_SOURCE $DIR_BUILD $DIR_SCRIPT; do
	if [ ! -d "${PWD}/$i" ]; then
		error "Not found dir '${PWD}/$i'"
	fi
done

# installing and setting docker image
if [ -z $(docker image ls --format HAVE ${GPKG_DEV_IMAGE}:${arch}) ]; then
	docker pull ${GPKG_DEV_IMAGE}:${arch}
	docker run -t -d --name builder -v "${PWD}/${DIR_BUILD}:${GPKG_DEV_DIR_BUILD}" \
		-v "${PWD}/${DIR_SOURCE}:${GPKG_DEV_DIR_SOURCE}" \
		-v "${PWD}/${DIR_SCRIPT}:${GPKG_DEV_DIR_SCRIPT}" \
		${GPKG_DEV_IMAGE}:${arch}
	docker exec builder pacman -Syu --noconfirm
	if [ "$arch" = "x86_64" ] || [ "$arch" = "i686" ]; then
		docker exec builder sed -i 's/.pkg.tar.zst/.pkg.tar.xz/' /etc/makepkg.conf
	fi
fi

# running command in docker image
docker exec builder ${command#* }
