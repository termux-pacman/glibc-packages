#!/usr/bin/env bash

# system definitions
export LANG="en_US.UTF-8"
export TERMUX_PREFIX="/data/data/com.termux/files/usr"
export GLIBC_PREFIX="${TERMUX_PREFIX}/glibc"
export GPKG_DEV_FLAGS="-Wl,-rpath=${GLIBC_PREFIX}/lib"
export GPKG_DEV_CC=""
export GPKG_DEV_CXX=""
export GPKG_DEV_CARCH=""
export GPKG_DEV_TARGET=""
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

is_termux() {
	([ -n "$TERMUX_APK_RELEASE" ] || [ -n "$TERMUX_APP_PID" ] || [ -n "$TERMUX_VERSION" ]) && [ $(uname -o) = "Android" ]
	return $?
}

check_not_termux() {
	if $(is_termux); then
		error "does not support running on termux"
	fi
}
