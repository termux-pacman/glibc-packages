#!/usr/bin/env bash

if [ ! -d /data ]; then
	mkdir /data
	chmod a+rwx /data
	chown ${GPKG_DEV_USER_NAME} /data
	chgrp ${GPKG_DEV_USER_NAME} /data
fi

if [ $ARCH = "arm" ] && [ ! -f $GLIBC_PREFIX/lib/libgcc_s.so.1 ]; then
	sudo -H -u ${GPKG_DEV_USER_NAME} mkdir -p $GLIBC_PREFIX/lib
	sudo -H -u ${GPKG_DEV_USER_NAME} ln -s /usr/arm-linux-gnueabihf/lib/libgcc_s.so.1 $GLIBC_PREFIX/lib/libgcc_s.so.1
fi
