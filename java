#!/bin/bash
URL=https://github.com/openjdk/jdk17u/archive/jdk-17.0.2-ga.tar.gz
TAR=$(echo $URL | sed -r 's|(.*)/||')
DIR=jdk17u-jdk-17.0.2-ga
PACKAGE=openjdk-17

# Get Package

cd /blfs/builds
wget $URL
tar -xvf $TAR
cd $DIR

# Build

# Assuming Java binary is in /opt/java/bin
export PATH=/opt/java/bin:$PATH


unset JAVA_HOME                                       &&
bash configure --enable-unlimited-crypto              \
               --disable-warnings-as-errors           \
               --with-stdc++lib=dynamic               \
               --with-giflib=system                   \
               --with-lcms=system                     \
               --with-libjpeg=system                  \
               --with-libpng=system                   \
               --with-zlib=system                     \
               --with-version-build="8"               \
               --with-version-pre=""                  \
	       --with-jobs=20                         \
               --with-version-opt=""                  \
               --with-cacerts-file=/etc/pki/tls/java/cacerts 


make images


# Install
install -vdm755 /pkgs/$PACKAGE/usr
cp -Rv build/*/images/jdk/* /pkgs/$PACKAGE/usr &&
chown -R root:root /pkgs/$PACKAGE/usr          &&
for s in 16 24 32 48; do
  install -vDm644 src/java.desktop/unix/classes/sun/awt/X11/java-icon${s}.png \
                  /pkgs/$PACKAGE/usr/share/icons/hicolor/${s}x${s}/apps/java.png
done
ln -sfv /etc/pki/tls/java/cacerts /pkgs/$PACKAGE/usr/lib/security/cacerts
cd /pkgs



sudo echo "" > /pkgs/$PACKAGE/depends
sudo echo "" > /pkgs/$PACKAGE/make-depends
sudo tar -cvzpf $PACKAGE.tar.xz $PACKAGE
sudo cp $PACKAGE.tar.xz /finished


cd /blfs/builds
sudo rm -r $DIR


