# Glibc packages for termux
![GitHub repo size](https://img.shields.io/github/repo-size/termux-pacman/glibc-packages)
![Build-gpkg last build status](https://github.com/termux-pacman/glibc-packages/workflows/Build%20gpkg/badge.svg)
![Build-gpkg-dev last build status](https://github.com/termux-pacman/glibc-packages/workflows/build-dev/badge.svg)

This repository stores and compiles packages based on the glibc library for termux.

More information in the [Wiki section](https://github.com/termux-pacman/glibc-packages/wiki).

### Contribution
Read [CONTRIBUTING.md](/CONTRIBUTING.md) for more details.

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
 - Organization maintaining: [termux-pacman](https://github.com/termux-pacman)
