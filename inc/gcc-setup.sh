#!/bin/sh

sudo apt-get -y install gcc g++ gcc-multilib g++-multilib autoconf libtool

sudo apt-get -y install build-essential zlib1g-dev libcurl4-openssl-dev libopenal-dev x11proto-xf86dga-dev libxxf86dga-dev libxxf86vm-dev libxinerama-dev libxcb-xinerama0-dev libxrandr-dev libjpeg-dev libpng12-dev libvorbis-dev libsdl1.2-dev libfreetype6-dev libtheora-dev

sudo apt-get -y install ia32-libs

mkdir -p deb/temp
cd deb

sudo apt-get download libx11-dev:i386 libxxf86dga-dev:i386 libxext6:i386 libxext-dev:i386 libxxf86dga1:i386 libxxf86dga-dev:i386 libxxf86vm-dev:i386 libxinerama-dev:i386 libxrender-dev:i386 libxrandr-dev:i386 libsdl1.2debian:i386 libsdl1.2-dev:i386 libopenal-dev:i386

for f in *.deb; do dpkg-deb -x $f temp ; done
sudo cp --preserve=all -d -n * ./temp/usr/lib/* /usr/lib/i386-linux-gnu/
sudo cp --preserve=all -d -n * ./temp/usr/lib/i386-linux-gnu/* /usr/lib/i386-linux-gnu/

cd ..
rm -rf ./deb
