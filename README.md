# Glibc packages for termux
This repository stores and compiles packages based on the glibc library for termux.

### Repositories and their description:
 - `gpkg-dev` is a repository that provides glibc packages for testing or for compiling final glibc packages - [more](https://github.com/termux-pacman/glibc-packages/wiki/About-repositories#description).
 - `gpkg` is a repository that provides the final version of glibc packages for full use - [more](https://github.com/termux-pacman/glibc-packages/wiki/About-repositories#description-1).

### Code for connecting repository:
gpkg-dev:
```
[gpkg-dev]
Server = https://service.termux-pacman.dev/gpkg-dev/$arch
```

### Other information:
 - [Old README](/README-old.md)
 - Architecture support: all (aarch64, arm, x86_64, i686)
 - Security level: full (db and packages are protected by signature)
 - Signature: termux-pacman organization gpg key
 - Powered by aws
 - Mirrors: does not exist
 - Organization maintaining: [termux-pacman](https://github.com/termux-pacman)
