#!/usr/bin/env bash

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
