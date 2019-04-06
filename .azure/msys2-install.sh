#!/bin/bash

set -e

export MSYS2_FC_CACHE_SKIP=1

pacman --noconfirm -Suy

pacman --noconfirm -S --needed \
    base-devel \
    git \
    mingw-w64-x86_64-toolchain \
    mingw-w64-x86_64-qt5  