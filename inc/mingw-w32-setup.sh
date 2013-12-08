#!/bin/sh

sudo mkdir -p /opt/mingw-w32
curl -L "http://downloads.sourceforge.net/project/mingw-w64/Toolchains%20targetting%20Win32/Automated%20Builds/mingw-w32-bin_x86_64-linux_20131208.tar.bz2" -o - | \
    sudo tar -xjf - -C /opt/mingw-w32
