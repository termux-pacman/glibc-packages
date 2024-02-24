
# version: 2.0

_glibc-runner_message() {
	echo "Message from glibc-runner: $1"
}

_glibc-runner_error() {
	echo "Error from glibc-runner: $1"
	exit 1
}

_glibc-runner_set_up_shell() {
	unset LD_PRELOAD
	export PATH_LIBTERMUX_EXEC_GLIBC="${GLIBC_PREFIX}/lib/libtermux-exec.so"
	export PATH_GLIBC_RUNNER_BASHRC="${APP_PREFIX}/etc/glibc-runner.bashrc"
	export PATH_RESULT_STRACE_DEBUG=""
	export ENABLED_LIBTERMUX_EXEC_GLIBC=false

	if [ ! -d "${GLIBC_PREFIX}/bin" ]; then
		_glibc-runner_error "'${GLIBC_PREFIX}/bin' not found, there is a risk that some functions will not work"
	fi
	export PATH="${GLIBC_PREFIX}/bin:${PATH}"

	if [ "${GLIBC_RUNNER_RUN_DEBUG}" = "true" ] && [ "${DEBUG_LEVEL_STRACE}" = "4" ]; then
		export PATH_RESULT_STRACE_DEBUG="$(pwd)/glibc-runner-debug-strace-$(date +%Y%m%d%H%M%S).log"
		_glibc-runner_message "the strace result will be '${PATH_RESULT_STRACE_DEBUG}'"
	fi

	if [ -f "${PATH_GLIBC_RUNNER_BASHRC}" ]; then
		source "${PATH_GLIBC_RUNNER_BASHRC}"
	fi
}

_glibc-runner_set_up_teg() {
	if [ "$ENABLED_LIBTERMUX_EXEC_GLIBC" = "false" ]; then
		if [ ! -f "${PATH_LIBTERMUX_EXEC_GLIBC}" ]; then
			_glibc-runner_error "not found '$PATH_LIBTERMUX_EXEC_GLIBC'"
		fi
		if [ -z $LD_PRELOAD ]; then
			export LD_PRELOAD=$PATH_LIBTERMUX_EXEC_GLIBC
		else
			export LD_PRELOAD="${PATH_LIBTERMUX_EXEC_GLIBC}:${LD_PRELOAD}"
		fi
		export ENABLED_LIBTERMUX_EXEC_GLIBC=true
	fi
}

_glibc-runner_set_up_binary() {
	_glibc-runner_check_program "patchelf"
	local LD_FILE=$(ls $GLIBC_PREFIX/lib/ld-* 2> /dev/null)
	if [ -z "$LD_FILE" ]; then
		_glibc-runner_error "interpreter not found in '$GLIBC_PREFIX/lib' directory"
	fi
	patchelf --set-rpath $GLIBC_PREFIX/lib \
		--set-interpreter $LD_FILE \
		"$1"
}

_glibc-runner_findlib() {
	_glibc-runner_check_program "objdump"
	_glibc-runner_message "searching for libraries..."
	local result
	if [ -z "$LD_LIBRARY_PATH" ]; then
		result=("${GLIBC_PREFIX}/lib")
	else
		result=(${LD_LIBRARY_PATH//:/ })
		if ! $(tr -s ' ' '\n' <<< "${result[@]}" | grep -q "^${GLIBC_PREFIX}/lib$"); then
			result=("${GLIBC_PREFIX}/lib" ${result[@]})
		fi
	fi
	local listlibs="$(find ${result[@]} -type f -o -type l)"
	local pwddir="$(find $(pwd) -type f -o -type l)"
	for i in $(objdump -p "$1" | grep NEEDED | awk '{printf $2 " "}'); do
		if [ "$i" = "linux-vdso.so.1" ]; then
			continue
		fi
		local libname=${i##*/}
		if $(grep -q "/${libname}$" <<< "${listlibs}"); then
			continue
		fi
		local pathlib=$(grep -m1 "/${libname}$" <<< "${pwddir}")
		if [ -z "${pathlib}" ]; then
			_glibc-runner_error "could not find '${libname}'"
		fi
		result+=("$(dirname $pathlib)")
		listlibs="$(find ${result[@]} -type f -o -type l)"
	done
	_glibc-runner_message "searching libraries was successful"
	export LD_LIBRARY_PATH=$(tr -s ' ' ':' <<< "${result[@]}")
}

_glibc-runner_debug() {
	if [ "${GLIBC_RUNNER_RUN_DEBUG}" = "true" ] && ((DEBUG_LEVEL_STRACE > 0)); then
		local FLAGS_STRACE
		case ${DEBUG_LEVEL_STRACE} in
			1) FLAGS_STRACE="";;
			2) FLAGS_STRACE="-f";;
			3) FLAGS_STRACE="-f -s 10000";;
			4) FLAGS_STRACE="-f -s 10000 -o ${PATH_RESULT_STRACE_DEBUG:=$(pwd)/glibc-runner-debug-strace-$(date +%Y%m%d%H%M%S).log}";;
		esac
		echo "strace ${FLAGS_STRACE}"
	fi
}

_glibc-runner_run_shell() {
	local command="$@"
	if [ -z "$command" ]; then
		exec $(_glibc-runner_debug) ${SHELL:=$GLIBC_PREFIX/bin/bash}
	else
		exec $(_glibc-runner_debug) ${SHELL:=$GLIBC_PREFIX/bin/bash} -c "$command"
	fi
	exit $?
}

_glibc-runner_info_message() {
	if [ "${RUNNING_IN_GLIBC_RUNNER}" != "true" ]; then
		_glibc-runner_error "shell is not running"
	fi

	echo "Information about the shell environment from glibc-runner:"
	echo "APP_PREFIX='${APP_PREFIX}'"
	echo "GLIBC_PREFIX='${GLIBC_PREFIX}'"
	echo "PATH_LIBTERMUX_EXEC_GLIBC='${PATH_LIBTERMUX_EXEC_GLIBC}'"
	echo "PATH_GLIBC_RUNNER_BASHRC='${PATH_GLIBC_RUNNER_BASHRC}'"
	echo "PATH_RESULT_STRACE_DEBUG='${PATH_RESULT_STRACE_DEBUG}'"
	echo "ENABLED_LIBTERMUX_EXEC_GLIBC='${ENABLED_LIBTERMUX_EXEC_GLIBC}'"
	echo "DEBUG_LEVEL_STRACE='${DEBUG_LEVEL_STRACE}'"
	echo "PATH='${PATH}'"
	echo "SHELL='${SHELL}'"
	echo "LD_PRELOAD='${LD_PRELOAD}'"
	echo "LD_LIBRARY_PATH='${LD_LIBRARY_PATH}'"
	echo ""
	if [ -f "${PATH_GLIBC_RUNNER_BASHRC}" ]; then
		echo "Found '${PATH_GLIBC_RUNNER_BASHRC}':"
		cat "${PATH_GLIBC_RUNNER_BASHRC}"
		echo "The End"
	else
		echo "Not found '${PATH_GLIBC_RUNNER_BASHRC}'"
	fi
}

_glibc-runner_help_message() {
	echo "Help message from glibc-runner v@TERMUX_PKG_VERSION@"
	echo ""
	echo "glibc-runner - launcher for working with the glibc shell or with a glibc-based binary"
	echo ""
	echo "Options:"
	echo " --help      -h  print help message"
	echo " --info      -i  print information about the running glibc-runner shell"
	echo " --shell     -s  run the glibc-runner shell or a command from that shell"
	echo " --teg       -t  enable the use of termux-exec-glibc in the glibc-runner shell"
	echo " --configure -c  configure the binary to run on the device"
	echo " --findlib   -f  find libraries for the binary"
	echo " --no-linker -n  don't use dynamic linker to launch binary"
	echo " --debug     -d  [1|2|3|4]  launch binary or shell under strace"
	echo ""
	echo "Example: glibc-runner [-c|-f|-n] ./binary || grun [-s|-n|-t] [gcc -v]"
	echo ""
	echo "Bug report: https://github.com/termux-pacman/glibc-packages/issues"
	exit 0
}

_glibc-runner_check_program() {
	if ! $(type $1 &> /dev/null); then
		_glibc-runner_error "program '$1' not found"
	fi
}

_glibc-runner_check_binary() {
	if [ -z "$1" ]; then
		_glibc-runner_error "binary not specified"
	fi

	if [ ! -f "$1" ]; then
		_glibc-runner_error "'$1' not found"
	fi

	if grep -qI . "$1"; then
		_glibc-runner_error "it looks like '$1' is not a binary"
	fi
}

if [ "${RUNNING_IN_GLIBC_RUNNER}" != "true" ]; then
	export APP_PREFIX="@TERMUX_PREFIX_CLASSICAL@"
	export GLIBC_PREFIX="${APP_PREFIX}/glibc"
	if [ ! -d "${GLIBC_PREFIX}/lib/" ]; then
		_glibc-runner_error "'${GLIBC_PREFIX}/lib/' not found, are you sure glibc is installed?"
	fi
	export DEBUG_LEVEL_STRACE=0
fi

if [ "$#" = "0" ]; then
	_glibc-runner_help_message
fi

ENABLE_LIBTERMUX_EXEC_GLIBC=false
DISABLE_DYNAMIC_LINKER=false
GLIBC_RUNNER_RUN_SHELL=false
GLIBC_RUNNER_RUN_FINDLIB=false
GLIBC_RUNNER_RUN_CONFIGURE=false
GLIBC_RUNNER_RUN_DEBUG=false

while (($# >= 1)); do
	case "$1" in
		-h|--help) _glibc-runner_help_message;;
		-i|--info) _glibc-runner_info_message;;
		-s|--shell) GLIBC_RUNNER_RUN_SHELL=true;;
		-t|--teg) ENABLE_LIBTERMUX_EXEC_GLIBC=true;;
		-c|--configure) GLIBC_RUNNER_RUN_CONFIGURE=true;;
		-f|--findlib) GLIBC_RUNNER_RUN_FINDLIB=true;;
		-n|--no-linker) DISABLE_DYNAMIC_LINKER=true;;
		-d|--debug)
			if [ "${GLIBC_RUNNER_RUN_SHELL}" = "true" ] && ((DEBUG_LEVEL_STRACE > 0)); then
				_glibc-runner_error "debug is already enabled inside the glibc-runner shell"
			fi
			if [[ "$2" =~ ^[0-4]+$ ]]; then
				export DEBUG_LEVEL_STRACE=$2
				shift 1
			else
				export DEBUG_LEVEL_STRACE=1
			fi
			GLIBC_RUNNER_RUN_DEBUG=true;;
		*)
			if [ "$GLIBC_RUNNER_RUN_SHELL" = "true" ] || [ "$DISABLE_DYNAMIC_LINKER" = "true" ]; then
				if [ "$GLIBC_RUNNER_RUN_SHELL" = "true" ]; then
					_glibc-runner_message "there is no point in using the '--no-linker' flag since the shell will be launched"
				fi
				break
			fi
			if [ -f "$1" ]; then
				break
			fi
			_glibc-runner_error "incorrect flag or binary to run, run 'glibc-runner --help' for instructions on how to use glibc-runner";;
	esac
	shift 1
done

if [ "${RUNNING_IN_GLIBC_RUNNER}" != "true" ]; then
        _glibc-runner_set_up_shell
        export RUNNING_IN_GLIBC_RUNNER=true
fi

if [ "${GLIBC_RUNNER_RUN_DEBUG}" = "true" ]; then
	_glibc-runner_check_program "strace"
	if ! [[ "$DEBUG_LEVEL_STRACE" =~ ^[0-4]+$ ]]; then
		_glibc-runner_error "DEBUG_LEVEL_STRACE value has an unidentified level, it can only be from 0 to 4"
	fi
fi

if [ "${GLIBC_RUNNER_RUN_CONFIGURE}" = "true" ] || [ "${GLIBC_RUNNER_RUN_FINDLIB}" = "true" ]; then
	_glibc-runner_check_binary "$1"
	if [ "${GLIBC_RUNNER_RUN_CONFIGURE}" = "true" ]; then
		_glibc-runner_set_up_binary "$1"
	fi
	if [ "${GLIBC_RUNNER_RUN_FINDLIB}" = "true" ]; then
		_glibc-runner_findlib "$1"
	fi
fi

if [ "${ENABLE_LIBTERMUX_EXEC_GLIBC}" = "true" ]; then
	_glibc-runner_set_up_teg
fi

if [ "${GLIBC_RUNNER_RUN_SHELL}" = "true" ]; then
	_glibc-runner_run_shell "$@"
else
	if [ -n "$1" ]; then
		if [ "${DISABLE_DYNAMIC_LINKER}" = "true" ]; then
			exec $(_glibc-runner_debug) $@
		else
			exec $(_glibc-runner_debug) ld.so $@
		fi
	fi
fi

exit $?
