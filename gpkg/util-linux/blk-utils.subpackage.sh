TERMUX_SUBPKG_DESCRIPTION="Utilities for handling block device attributes"
TERMUX_SUBPKG_DEPENDS="libblkid-glibc, libmount-glibc, libsmartcols-glibc, libuuid-glibc, gcc-libs-glibc"
TERMUX_SUBPKG_BREAKS="util-linux-glibc (<< 2.38.1-1)"
TERMUX_SUBPKG_REPLACES="util-linux-glibc (<< 2.38.1-1)"
TERMUX_SUBPKG_DEPEND_ON_PARENT="no"
TERMUX_SUBPKG_INCLUDE="
glibc/bin/blkdiscard
glibc/bin/blkid
glibc/bin/blkzone
glibc/bin/findfs
glibc/bin/fsck
glibc/bin/lsblk
glibc/bin/mkswap
glibc/bin/partx
glibc/bin/swaplabel
glibc/bin/wipefs
glibc/share/bash-completion/completions/blkdiscard
glibc/share/bash-completion/completions/blkid
glibc/share/bash-completion/completions/blkzone
glibc/share/bash-completion/completions/findfs
glibc/share/bash-completion/completions/fsck
glibc/share/bash-completion/completions/lsblk
glibc/share/bash-completion/completions/mkswap
glibc/share/bash-completion/completions/partx
glibc/share/bash-completion/completions/swaplabel
glibc/share/bash-completion/completions/wipefs
glibc/share/man/man8/blkdiscard.8.gz
glibc/share/man/man8/blkid.8.gz
glibc/share/man/man8/blkzone.8.gz
glibc/share/man/man8/findfs.8.gz
glibc/share/man/man8/fsck.8.gz
glibc/share/man/man8/lsblk.8.gz
glibc/share/man/man8/mkswap.8.gz
glibc/share/man/man8/partx.8.gz
glibc/share/man/man8/swaplabel.8.gz
glibc/share/man/man8/wipefs.8.gz
"
