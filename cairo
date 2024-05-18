#!/bin/bash

export CFLAGS=-"O2"
export CXXFLAGS="-O2"


PKG_VER=1.17.6
MAJOR=$(echo $PKG_VER | sed 's|.[^.]*$||g')
URL=https://www.cairographics.org/releases/cairomm-$PKG_VER.tar.xz
TAR=$(echo $URL | sed -r 's|(.*)/||')
DIR=$(echo $TAR | sed 's|.tar.*||g')
PACKAGE=$(echo $DIR | sed 's|-[^-]*$||g')

# Get Package

cd /blfs/builds
wget $URL
tar -xvf $TAR
cd $DIR

# Build

meson setup \
      --prefix=/usr \
      --buildtype=release \
      ..

ninja

# Install
sudo DESTDIR=/pkgs/$PACKAGE ninja install
sudo ninja install 
cd /pkgs



sudo echo "pixman libpng fontconfig glib xorg-libs" > /pkgs/$PACKAGE/depends
sudo echo "" > /pkgs/$PACKAGE/make-depends
sudo tar -cvzpf $PACKAGE.tar.xz $PACKAGE
sudo cp $PACKAGE.tar.xz /finished


cd /blfs/builds
sudo rm -r $DIR


