TERMUX_SUBPKG_INCLUDE="
glibc/bin/showdb
glibc/bin/showjournal
glibc/bin/showstat4
glibc/bin/showwal
glibc/bin/sqldiff
glibc/bin/sqlite3
glibc/share/man/man1/
"
TERMUX_SUBPKG_DESCRIPTION="Command line shell for SQLite"
TERMUX_SUBPKG_DEPEND_ON_PARENT=deps
TERMUX_SUBPKG_DEPENDS="readline-glibc"
