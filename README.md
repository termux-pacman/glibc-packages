# Glibc packages for termux
This repository stores and compiles packages based on the glibc library for termux.
**Note:** the repositories are currently under development, so requests to add new packages will not be accepted.

### Repositories and their description:
 - `gpkg-dev` are builds that are configured to compile on a linux distribution (or on proot-distro).
 - `gpkg` are builds that are configured to compile on termux.

### Code for connecting repository:
gpkg-dev:
<!--```
[gpkg-dev]
Server = https://service.termux-pacman.dev/gpkg-dev/$arch
```-->
```
[gpkg-dev]
Server = https://s3.amazonaws.com/termux-pacman.us/gpkg-dev/$arch
```

### Other information:
 - [Old README](/README-old.md)
 - Architecture support: aarch64 and arm
 - Security level: full (db and packages are protected by signature)
 - Signature: termux-pacman organization gpg key
 - Storage: aws s3 (US)
 - Mirrors: does not exist
 - Organization maintaining: [termux-pacman](https://github.com/termux-pacman)
