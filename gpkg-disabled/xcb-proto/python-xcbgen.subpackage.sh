TERMUX_SUBPKG_INCLUDE="glibc/lib/python*"
TERMUX_SUBPKG_DESCRIPTION="The xcbgen Python module"
# Cannot depend on python due to circular dependency.
TERMUX_SUBPKG_RECOMMENDS="python-glibc"
TERMUX_SUBPKG_BREAKS="xcb-proto-glibc (<< 1.15.2)"
TERMUX_SUBPKG_REPLACES="xcb-proto-glibc (<< 1.15.2)"
