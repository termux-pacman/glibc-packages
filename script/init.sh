#!/usr/bin/env bash

# system definitions
DIR_SOURCE="gpkg-dev"
DIR_BUILD="pkgs"
DIR_SCRIPT="script"
GPKG_DEV_USER_NAME="user-build"
GPKG_DEV_USER_HOME="/home/${GPKG_DEV_USER_NAME}"
GPKG_DEV_DIR_SOURCE="${GPKG_DEV_USER_HOME}/${DIR_SOURCE}"
GPKG_DEV_DIR_BUILD="${GPKG_DEV_USER_HOME}/${DIR_BUILD}"
GPKG_DEV_DIR_SCRIPT="${GPKG_DEV_USER_HOME}/${DIR_SCRIPT}"
GPKG_DEV_IMAGE=ghcr.io/termux-pacman/archlinux-builder

# functions
error() {
	echo "Error: $@"
	exit 1
}

chech_not_termux() {
	if ([ -n "$TERMUX_APK_RELEASE" ] || \
	[ -n "$TERMUX_APP_PID" ] || \
	[ -n "$TERMUX_VERSION" ]) && \
	[ $(uname -o) = "Android" ]; then
		error "does not support running on termux"
	fi
}
