#!/usr/bin/env bash

# system definitions
export LANG="en_US.UTF-8"
export DIR_TERMUX="/data/data/com.termux"
export TERMUX_PREFIX="${DIR_TERMUX}/files/usr"
export GLIBC_PREFIX="${TERMUX_PREFIX}/glibc"
export CGCT_PATH="${DIR_TERMUX}/cgct"
export SERVER_URL="https://service.termux-pacman.dev"

DIR_SOURCE="cgct"
DIR_BUILD="pkgs"
DIR_SCRIPT="scripts-cgct"
export IMAGE_PATH_SOURCE="${PWD}/${DIR_SOURCE}"
export IMAGE_PATH_BUILD="${PWD}/${DIR_BUILD}"
export IMAGE_PATH_SCRIPT="${PWD}/${DIR_SCRIPT}"

CGCT_FILE_DELETING="deleted_cgct_packages.txt"
