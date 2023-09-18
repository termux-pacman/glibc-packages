TERMUX_SUBPKG_DESCRIPTION="Utilities for (un)mounting filesystems"
TERMUX_SUBPKG_DEPENDS="libblkid-glibc, libsmartcols-glibc, libmount-glibc, gcc-libs-glibc"
TERMUX_SUBPKG_DEPEND_ON_PARENT="no"
TERMUX_SUBPKG_INCLUDE="
glibc/bin/findmnt
glibc/bin/fstrim
glibc/bin/lslocks
glibc/bin/mount
glibc/bin/swapoff
glibc/bin/swapon
glibc/bin/umount
glibc/share/bash-completion/completions/findmnt
glibc/share/bash-completion/completions/fstrim
glibc/share/bash-completion/completions/lslocks
glibc/share/bash-completion/completions/mount
glibc/share/bash-completion/completions/swapoff
glibc/share/bash-completion/completions/swapon
glibc/share/bash-completion/completions/umount
glibc/share/man/man8/findmnt.8.gz
glibc/share/man/man8/fstrim.8.gz
glibc/share/man/man8/lslocks.8.gz
glibc/share/man/man8/mount.8.gz
glibc/share/man/man8/swapoff.8.gz
glibc/share/man/man8/swapon.8.gz
glibc/share/man/man8/umount.8.gz
"
