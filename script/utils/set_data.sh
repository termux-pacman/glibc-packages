#!/usr/bin/env bash

if [ ! -d /data ]; then
	mkdir /data
	chmod a+rwx /data
	chown ${GPKG_DEV_USER_NAME} /data
	chgrp ${GPKG_DEV_USER_NAME} /data
fi
