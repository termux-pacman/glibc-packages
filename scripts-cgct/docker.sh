#!/usr/bin/bash

set -e

# adding configuration
. $(dirname "$(realpath "$0")")/init.sh
. $(dirname "$(realpath "$0")")/functions/error.sh
IMAGE_URL="ghcr.io/termux-pacman/archlinux-builder"
IMAGE_USER_NAME="user-build"
IMAGE_USER_HOME="/home/${IMAGE_USER_NAME}"
IMAGE_PATH_BUILD="${IMAGE_USER_HOME}/${DIR_BUILD}"
IMAGE_PATH_SOURCE="${IMAGE_USER_HOME}/${DIR_SOURCE}"
IMAGE_PATH_SCRIPT="${IMAGE_USER_HOME}/${DIR_SCRIPT}"

if [ "$(id -u)" != "0" ]; then
	error "docker.sh must be run as root"
fi

# checking dirs for existence
for i in $DIR_SOURCE $DIR_BUILD $DIR_SCRIPT; do
	if [ ! -d "${PWD}/$i" ]; then
		error "Not found dir '${PWD}/$i'"
	fi
done

# installing and setting docker image
if [ -z $(docker image ls --format HAVE ${IMAGE_URL}) ]; then
	docker pull ${IMAGE_URL}
fi
docker_exec="docker exec -i builder"
if ! $(docker container ls | grep -q builder); then
	docker run -t -d --name builder -v "${PWD}/${DIR_BUILD}:${IMAGE_PATH_BUILD}" \
		-v "${PWD}/${DIR_SOURCE}:${IMAGE_PATH_SOURCE}" \
		-v "${PWD}/${DIR_SCRIPT}:${IMAGE_PATH_SCRIPT}" \
		${IMAGE_URL}
	$docker_exec sudo pacman -Syu --noconfirm
	yes | $docker_exec sudo pacman -Scc
	$docker_exec sudo sed -i 's/.pkg.tar.zst/.pkg.tar.xz/' /etc/makepkg.conf
	$docker_exec sudo sed -i 's|^#PACKAGER=.*$|PACKAGER="Termux-Pacman <pacman@termux.dev>"|' /etc/makepkg.conf
	$docker_exec sudo sed -i 's| debug | !debug |g' /etc/makepkg.conf
	$docker_exec sudo chown "$IMAGE_USER_NAME" "${IMAGE_PATH_BUILD}"
	$docker_exec sudo chgrp "$IMAGE_USER_NAME" "${IMAGE_PATH_BUILD}"
	if [ -d $DIR_BUILD/PKGBUILDs ]; then
		$docker_exec sudo chown "$IMAGE_USER_NAME" "${IMAGE_PATH_BUILD}/PKGBUILDs"
		$docker_exec sudo chgrp "$IMAGE_USER_NAME" "${IMAGE_PATH_BUILD}/PKGBUILDs"
		for pb in $(ls $DIR_BUILD/PKGBUILDs); do
			$docker_exec sudo chown "$IMAGE_USER_NAME" "${IMAGE_PATH_BUILD}/PKGBUILDs/${pb}"
			$docker_exec sudo chgrp "$IMAGE_USER_NAME" "${IMAGE_PATH_BUILD}/PKGBUILDs/${pb}"
		done
	fi
fi

DOCKER_FLAG=""
if [ "$#" = "0" ]; then
	set -- bash
	DOCKER_FLAG="-t"
fi

# running command in docker image
docker exec -i $DOCKER_FLAG builder "${@}"
