TERMUX_SUBPKG_DESCRIPTION="Convert between Git and Subversion repositories"
TERMUX_SUBPKG_DEPENDS="subversion-perl-glibc"
TERMUX_SUBPKG_PLATFORM_INDEPENDENT=true
TERMUX_SUBPKG_INCLUDE="
glibc/libexec/git-core/git-svn*
glibc/share/man/man1/git-svn*
glibc/share/perl5/Git/SVN*
"
