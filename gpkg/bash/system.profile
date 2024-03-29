#
# @TERMUX_PREFIX@/etc/profile
#

for i in @TERMUX_PREFIX@/etc/profile.d/*.sh; do
	if [ -r $i ]; then
		. $i
	fi
done
unset i

# Source etc/bash.bashrc and ~/.bashrc also for interactive bash login shells:
if [ "$BASH" ]; then
        if [[ "$-" == *"i"* ]]; then
                if [ -r @TERMUX_PREFIX@/etc/bash.bashrc ]; then
                        . @TERMUX_PREFIX@/etc/bash.bashrc
                fi
        fi
fi
