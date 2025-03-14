#!/bin/bash

# Script that installs build-package.sh to compile glibc packages

BRANCH="exclude-pycache-during-extract-into-massagedir"

git clone --depth 1 -b ${BRANCH} --single-branch https://github.com/robertkirkman/termux-packages.git

for i in build-package.sh clean.sh packages x11-packages root-packages scripts ndk-patches; do
	rm -fr ./${i}
	cp -r ./termux-packages/${i} ./
done

rm -fr termux-packages
