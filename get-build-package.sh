#!/bin/bash

# Script that installs build-package.sh to compile glibc packages

git clone https://github.com/termux/termux-packages.git

for i in build-package.sh clean.sh packages x11-packages scripts; do
	cp -r ./termux-packages/${i} ./
done

rm -fr termux-packages
