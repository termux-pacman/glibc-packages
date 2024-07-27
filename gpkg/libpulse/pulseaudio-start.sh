#!@TERMUX_PREFIX@/bin/bash

# A simple script that simplifies the configuration of pulseaudio-glibc

unset LD_PRELOAD
unset PULSE_SERVER

PA_IP="127.0.0.1"

pa_pid=$(pidof "@TERMUX_PREFIX_CLASSICAL@/bin/pulseaudio")
if [ -n "${pa_pid}" ]; then
	kill ${pa_pid}
fi

if [ "${1}" = "-kill" ] || [ "${1}" = "-k" ]; then
	if [ -n "${pa_pid}" ]; then
		echo "pulseaudio was stopped successfully"
	fi
	exit 0
fi

@TERMUX_PREFIX_CLASSICAL@/bin/pulseaudio --start --exit-idle-time=-1 || exit 1
@TERMUX_PREFIX_CLASSICAL@/bin/pacmd load-module module-native-protocol-tcp auth-ip-acl=${PA_IP} auth-anonymous=1 || exit 1

echo "To make pulseaudio-glibc work, copy and paste this command into your shell:"
echo
echo " export PULSE_SERVER=${PA_IP}"
echo
