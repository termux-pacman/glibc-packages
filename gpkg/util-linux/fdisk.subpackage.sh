TERMUX_SUBPKG_DESCRIPTION="Utilities to manipulate disk partition tables"
TERMUX_SUBPKG_DEPENDS="libfdisk-glibc, libmount-glibc, ncurses-glibc, readline-glibc, libsmartcols-glibc"
TERMUX_SUBPKG_DEPEND_ON_PARENT="no"
TERMUX_SUBPKG_INCLUDE="
glibc/share/man/man8/cfdisk.8.gz
glibc/share/man/man8/fdisk.8.gz
glibc/share/man/man8/sfdisk.8.gz
glibc/share/bash-completion/completions/sfdisk
glibc/share/bash-completion/completions/fdisk
glibc/share/bash-completion/completions/cfdisk
glibc/bin/sfdisk
glibc/bin/fdisk
glibc/bin/cfdisk
"
