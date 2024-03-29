TERMUX_PKG_HOMEPAGE=https://github.com/scop/bash-completion
TERMUX_PKG_DESCRIPTION="Programmable completion for the bash shell"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=2.12.0
TERMUX_PKG_SRCURL=https://github.com/scop/bash-completion/releases/download/${TERMUX_PKG_VERSION}/bash-completion-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=3eb05b1783c339ef59ed576afb0f678fa4ef49a6de8a696397df3148f8345af9
TERMUX_PKG_DEPENDS="bash-glibc"
TERMUX_PKG_PLATFORM_INDEPENDENT=true
TERMUX_PKG_RM_AFTER_INSTALL="
glibc/share/bash-completion/completions/makepkg
"
