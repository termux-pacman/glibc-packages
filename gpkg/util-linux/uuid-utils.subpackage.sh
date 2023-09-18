TERMUX_SUBPKG_DESCRIPTION="Utilities for handling universally unique identifiers"
TERMUX_SUBPKG_DEPENDS="libsmartcols-glibc, libuuid-glibc, gcc-libs-glibc"
TERMUX_SUBPKG_DEPEND_ON_PARENT="no"
TERMUX_SUBPKG_INCLUDE="
glibc/share/man/man3/uuid_copy.3.gz
glibc/share/man/man3/uuid_generate.3.gz
glibc/share/man/man3/uuid.3.gz
glibc/share/man/man3/uuid_generate_time_safe.3.gz
glibc/share/man/man3/uuid_is_null.3.gz
glibc/share/man/man3/uuid_compare.3.gz
glibc/share/man/man3/uuid_parse.3.gz
glibc/share/man/man3/uuid_time.3.gz
glibc/share/man/man3/uuid_generate_time.3.gz
glibc/share/man/man3/uuid_generate_random.3.gz
glibc/share/man/man3/uuid_clear.3.gz
glibc/share/man/man3/uuid_unparse.3.gz
glibc/share/man/man1/uuidgen.1.gz
glibc/share/man/man1/uuidparse.1.gz
glibc/share/man/man8/uuidd.8.gz
glibc/share/bash-completion/completions/uuidd
glibc/share/bash-completion/completions/uuidgen
glibc/share/bash-completion/completions/uuidparse
glibc/bin/uuidd
glibc/bin/uuidgen
glibc/bin/uuidparse
"
