# Info
This repository stores AUR builds for compiling glibc packages and compiled glibc packages in pacman format in the releases department. Here the AUR builds are divided into two types: 
 - `distro` are builds that are configured to compile on a linux distribution (or on proot-distro).
 - `termux` are builds that are configured to compile on termux.

At the moment, glibc packages have only been compiled for`aarch64` and `arm (armv7)` architectures.

# Installation steps:
 1. **Installing the required packages.**  
    The most essential is `pacman`. If you are installing glibc packages that have been compiled on a linux distribution, then you will need `proot` (in the release of the packages there is information where they were compiled).
    ```bash
    pkg ins pacman -y # necessary
    pkg ins proot -y  # needed only when installing packages that have hard links
    ```
 2. **Installing the archive with glibc packages.**  
    *Important:* pay attention to where the packages were compiled, since the installation phase depends on it.
    ```bash
    # Installing the latest archive
    wget https://github.com/Maxython/glibc-for-termux/releases/download/20221025/gpft-20221025-${arch}.tar.xz
    tar xJf gpft-20221025-${arch}.tar.xz
    ```
 3. **Installing glibc packages.**  
    If you selected packages that were compiled in termux, then the installation should proceed like this:
    ```bash
    pacman -U glibc-for-termux/*
    ```
    If the packages that were compiled in the linux distribution, then the installation should proceed like this:
    ```bash
    proot --link2symlink pacman -U glibc-for-termux/*
    ```
 5. **Final.**  
    After installation, the `grun` command will be available, it is intended to run binaries that depend on glibc or to run a customized shell.  
    *For example:*  
     - `grun ./binary_file` - running binaries
     - `grun --shell` - running a customized shell (gives access to glibc commands)
