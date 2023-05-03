#!/usr/bin/env bash

# setting flags by architecture
export GPKG_DEV_FLAGS="-Wl,-rpath=$GLIBC_PREFIX/lib"
case $(pacman-conf Architecture) in
	"aarch64") export GPKG_DEV_FLAGS+=" -Wl,--dynamic-linker=$GLIBC_PREFIX/lib/ld-linux-aarch64.so.1";;
	"armv7h") export GPKG_DEV_FLAGS+=" -Wl,--dynamic-linker=$GLIBC_PREFIX/lib/ld-linux-armhf.so.3";;
	"x86_64") export GPKG_DEV_FLAGS+=" -Wl,--dynamic-linker=$GLIBC_PREFIX/lib/ld-linux-x86-64.so.2";;
	"i686") export GPKG_DEV_FLAGS+=" -Wl,--dynamic-linker=$GLIBC_PREFIX/lib/ld-linux.so.2";;
esac

# adding flags to makepkg.conf
if ! $(is_termux) && [ -f /etc/makepkg.conf ]; then
	if ! $(grep CFLAGS /etc/makepkg.conf | grep -q -e "$GPKG_DEV_FLAGS"); then
		echo 'CFLAGS="$CFLAGS '$GPKG_DEV_FLAGS'"' >> /etc/makepkg.conf
	fi
	if ! $(grep CXXFLAGS /etc/makepkg.conf | grep -q -e "$GPKG_DEV_FLAGS"); then
		echo 'CXXFLAGS="$CXXFLAGS '$GPKG_DEV_FLAGS'"' >> /etc/makepkg.conf
	fi
fi
