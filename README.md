# Glibc packages for termux
This repository stores and compiles packages based on the glibc library for termux.

More information in the [Wiki section](https://github.com/termux-pacman/glibc-packages/wiki).

### Contribution

You can create a [request](https://github.com/termux-pacman/glibc-packages/issues/new?assignees=&labels=package+request%2Cgpkg&projects=&template=package_request.yml&title=%5BPackage%5D%3A+) to add a new package or create a PR with the package. If you would like to create a PR, please review our [Package Addition Policy](https://github.com/termux-pacman/glibc-packages/wiki/Package-Addition-Policy).

### Code for connecting repository:
gpkg-dev:
```
[gpkg-dev]
Server = https://service.termux-pacman.dev/gpkg-dev/$arch
```
gpkg:
```
[gpkg]
Server = https://service.termux-pacman.dev/gpkg/$arch
```

### Other information:
 - [Old README](/README-old.md)
 - Architecture support: all (aarch64, arm, x86_64, i686)
 - Security level: full (db and packages are protected by signature)
 - Signature: termux-pacman organization gpg key
 - Powered by aws
 - Mirrors: does not exist
 - Organization maintaining: [termux-pacman](https://github.com/termux-pacman)
