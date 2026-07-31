TERMUX_PKG_HOMEPAGE=https://github.com/scop/bash-completion
TERMUX_PKG_DESCRIPTION="Programmable completion for the bash shell"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=2.18.0
TERMUX_PKG_SRCURL=https://github.com/scop/bash-completion/releases/download/${TERMUX_PKG_VERSION}/bash-completion-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=88bcf85124f77f74f2f2f8bcd16ac4382d807a827ede742a64940c7116aea33f
TERMUX_PKG_DEPENDS="bash-glibc"
TERMUX_PKG_PLATFORM_INDEPENDENT=true
TERMUX_PKG_RM_AFTER_INSTALL="
glibc/share/bash-completion/completions/makepkg
glibc/share/bash-completion/completions/secret-tool
"
