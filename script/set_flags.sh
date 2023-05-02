#!/usr/bin/env bash

# setting flags by architecture
FLAGS="-Wl,-rpath=$GLIBC_PREFIX/lib"
case $(pacman-conf Architecture) in
	"aarch64") FLAGS+=" -Wl,--dynamic-linker=$GLIBC_PREFIX/lib/ld-linux-aarch64.so.1";;
	"armv7h") FLAGS+=" -Wl,--dynamic-linker=$GLIBC_PREFIX/lib/ld-linux-armhf.so.3";;
	"x86_64") FLAGS+=" -Wl,--dynamic-linker=$GLIBC_PREFIX/lib/ld-linux-x86-64.so.2";;
	"i686") FLAGS+=" -Wl,--dynamic-linker=$GLIBC_PREFIX/lib/ld-linux.so.2";;
esac

# adding flags to makepkg.conf
if ! $(is_termux) && [ -f /etc/makepkg.conf ]; then
	if ! $(grep CFLAGS /etc/makepkg.conf | grep -q "$FLAGS"); then
		echo 'CFLAGS="$CFLAGS '$FLAGS'"' >> /etc/makepkg.conf
	fi
	if ! $(grep CXXFLAGS /etc/makepkg.conf | grep -q "$FLAGS"); then
		echo 'CXXFLAGS="$CXXFLAGS '$FLAGS'"' >> /etc/makepkg.conf
	fi
fi

export CFLAGS="${FLAGS}"
export CXXFLAGS="${FLAGS}"
