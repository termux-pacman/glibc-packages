# Info
This repository stores AUR builds for compiling glibc packages and compiled glibc packages in pacman format in the releases department. Here the AUR builds are divided into two types: 
 - `distro` are builds that are configured to compile on a linux distribution (or on proot-distro).
 - `termux` are builds that are configured to compile on termux.

At the moment, glibc packages have only been compiled for the `aarch64` architecture.

# Install
**Attention**: due to the fact that most packages are compiled in the linux distribution, installation must be done through `proot`.  
```bash
pkg ins wget proot pacman -y
wget https://github.com/Maxython/glibc-for-termux/releases/download/20220620/gpft-20220620-aarch64.tar.xz
tar xJf gpft-20220620-aarch64.tar.xz
proot --link2symlink pacman -U glibc-for-termux/*
```

After installation, the `grun` command will be available, it is intended to run binaries that depend on glibc or to run a customized shell.  
### For example:  
 - `grun ./binary_file` - running binaries
 - `grun --shell` - running a customized shell (gives access to glibc commands)
