#!/bin/bash

while getopts “p:v:” opt; do
  case ${opt} in
    p ) path=$OPTARG
      ;;
    v ) version=$OPTARG
      ;;
    \? ) echo "Usage: cmd [-p path to binary] [-v  version]"
      ;;
  esac
done

cp $path fasttrack/usr/bin/fasttrack

echo "Package: fasttrack
Version: $version
Maintainer: Benjamin Gallois <benjamin.gallois@fasttrack.sh>
Description: Track multiple objects in video recording
Homepage: https://www.fasttrack.sh
Architecture: all
Depends: qt5-default(>=5.7.1), qtwebengine5-dev, gdal-abi-2-2-3, libavcodec57 (>= 7:3.4.4) | libavcodec-extra57 (>= 7:3.4.4), libavformat57(>= 7:3.4.4), libavutil55 (>= 7:3.4.4), libc6 (>= 2.27), libcairo2 (>= 1.2.4), libdc1394-22, libfreetype6 (>= 2.2.1), libgcc1 (>= 1:4.0), libgdal20 (>= 2.0.1), libgdcm2.8, libgdk-pixbuf2.0-0 (>= 2.22.0), libglib2.0-0 (>= 2.31.8), libgoogle-glog0v5, libgtk-3-0 (>= 3.0.0), libharfbuzz0b (>= 0.9.9), libhdf5-100, libjpeg8 (>= 8c), libopenexr22, libpng16-16 (>= 1.6.2-1), libstdc++6 (>= 6), libswscale4(>= 7:3.4.4), libtbb2, libtiff5 (>= 4.0.3), libvtk6.3, libwebp6 (>= 0.5.1), zlib1g (>= 1:1.1.4), libiomp5" >> fasttrack/DEBIAN/control

dpkg-deb --build fasttrack
mv fasttrack.deb fasttrack-$version.deb

rm fasttrack/usr/bin/fasttrack
rm fasttrack/DEBIAN/control
