#!/bin/sh

wget -O mingw-w32.tar.bz2 http://downloads.sourceforge.net/project/mingw-w64/Toolchains%20targetting%20Win32/Automated%20Builds/mingw-w32-bin_x86_64-linux_20130622.tar.bz2?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fmingw-w64%2Ffiles%2FToolchains%2520targetting%2520Win32%2FAutomated%2520Builds%2F&ts=1379156712&use_mirror=optimate
sudo mkdir -p /opt/mingw-w32-bin_x86_64-linux_20130622
sudo tar xjf mingw-w32.tar.bz2 -C /opt/mingw-w32-bin_x86_64-linux_20130622
sudo ln -s /opt/mingw-w32-bin_x86_64-linux_20130622 /opt/mingw-w32 && rm mingw-w32.tar.bz2