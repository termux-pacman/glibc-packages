#!/usr/bin/env bash

# setting flags by architecture
case $ARCH in
	"aarch64")
		export GPKG_DEV_FLAGS+=" -Wl,--dynamic-linker=$GLIBC_PREFIX/lib/ld-linux-aarch64.so.1 -march=armv8-a"
		export GPKG_DEV_CC="aarch64-linux-gnu-gcc"
		export GPKG_DEV_CARCH="aarch64";;
	"arm")
		export GPKG_DEV_FLAGS+=" -Wl,--dynamic-linker=$GLIBC_PREFIX/lib/ld-linux-armhf.so.3 -march=armv7-a -mfloat-abi=hard -mfpu=neon"
		export GPKG_DEV_CC="arm-linux-gnueabihf-gcc"
		export GPKG_DEV_CARCH="armv7h"
		export GPKG_DEV_TARGET="armv7l-linux-gnueabihf";;
	"x86_64")
		export GPKG_DEV_FLAGS+=" -Wl,--dynamic-linker=$GLIBC_PREFIX/lib/ld-linux-x86-64.so.2 -march=x86-64"
		export GPKG_DEV_CC="x86_64-linux-gnu-gcc"
		export GPKG_DEV_CARCH="x86_64";;
	"i686")
		export GPKG_DEV_FLAGS+=" -Wl,--dynamic-linker=$GLIBC_PREFIX/lib/ld-linux.so.2 -march=i686"
		export GPKG_DEV_CC="x86_64-linux-gnu-gcc -m32"
		export GPKG_DEV_CARCH="i686";;
esac
if [ -z "$GPKG_DEV_TARGET" ]; then
	export GPKG_DEV_TARGET="${GPKG_DEV_CARCH}-linux-gnu"
fi
case $ARCH in
	"aarch64"|"arm") export GPKG_DEV_FLAGS+=" -fstack-protector-strong";;
	"x86_64"|"i686") export GPKG_DEV_FLAGS+=" -mtune=generic -fcf-protection";;
esac
export GPKG_DEV_CXX="$(echo $GPKG_DEV_CC | sed 's/gcc/g++/')"

# adding flags to makepkg.conf
if ! $(is_termux) && [ -f /etc/makepkg.conf ]; then
	if ! $(grep CFLAGS /etc/makepkg.conf | grep -q -e "$GPKG_DEV_FLAGS"); then
		echo 'CFLAGS="'$GPKG_DEV_FLAGS'"' >> /etc/makepkg.conf
		#echo 'CXXFLAGS="$CFLAGS -Wp,-D_GLIBCXX_ASSERTIONS"' >> /etc/makepkg.conf
	fi
	if ! $(grep CC /etc/makepkg.conf | grep -q "$GPKG_DEV_CC"); then
		echo 'export CC="'$GPKG_DEV_CC'"' >> /etc/makepkg.conf
	fi
	if ! $(grep CC /etc/makepkg.conf | grep -q "$GPKG_DEV_CXX"); then
		echo 'export CXX="'$GPKG_DEV_CXX'"' >> /etc/makepkg.conf
	fi
	if ! $(grep CARCH /etc/makepkg.conf | grep -q "$GPKG_DEV_CARCH"); then
		echo 'CARCH="'$GPKG_DEV_CARCH'"' >> /etc/makepkg.conf
	fi
fi
