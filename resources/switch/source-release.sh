#!/bin/sh

# Move to script directory so all relative paths work
cd "$(dirname "$0")"

# Includes
. ../config.sh

# Upgrade packages
apt update && apt upgrade -y

# Install dependencies
apt install -y autoconf automake devscripts g++ git-core libncurses-dev libtool make libjpeg-dev \
  pkg-config flac  libgdbm-dev libdb-dev gettext sudo equivs git dpkg-dev libpq-dev \
  liblua5.2-dev libtiff5-dev libperl-dev libcurl4-openssl-dev libsqlite3-dev libpcre3-dev \
  devscripts libspeexdsp-dev libspeex-dev libldns-dev libedit-dev libopus-dev libmemcached-dev \
  libshout3-dev libmpg123-dev libmp3lame-dev yasm nasm libsndfile1-dev libuv1-dev libvpx-dev \
  libavformat-dev libswscale-dev libspandsp-dev pip libpq-dev libvlc-dev uuid-dev sox libsox-fmt-all
  
# Additional dependencies
apt install -y swig3.0 unzip sox wget

CWD=$(pwd)

# sofia-sip
cd /usr/src
wget https://github.com/freeswitch/sofia-sip/archive/refs/tags/v$sofia_version.zip
unzip v$sofia_version.zip
cd sofia-sip-$sofia_version
sh autogen.sh
./configure
make
make install

# spandsp
cd /usr/src
git clone https://github.com/freeswitch/spandsp.git spandsp
cd spandsp
git reset --hard 0d2e6ac65e0e8f53d652665a743015a88bf048d4
/usr/bin/sed -i 's/AC_PREREQ(\[2\.71\])/AC_PREREQ([2.69])/g' /usr/src/spandsp/configure.ac
sh autogen.sh
./configure
make
make install
ldconfig

# FFMPEG 5.1 latest won't work currently.
cd /usr/src
apt install -y libfdk-aac-dev libx265-dev gcc-9 g++-9
CC=gcc-9
CXX=g++-9
wget https://ffmpeg.org/releases/ffmpeg-5.1.tar.bz2
tar xvjf ffmpeg-5.1.tar.bz2
cd ffmpeg-5.1
./configure --prefix=/usr/local --enable-gpl --enable-version3 --enable-nonfree --enable-shared --enable-libx264 --enable-libx265 --enable-libvpx --enable-libfdk-aac
make -j$(nproc)  # Compile using all available cores
sudo make install
CC=
CXX=

echo "Using version $switch_version"
cd /usr/src
wget http://files.freeswitch.org/freeswitch-releases/freeswitch-$switch_version.-release.zip -O freeswitch-$switch_version.-release.zip
unzip freeswitch-$switch_version.-release.zip
mv freeswitch-$switch_version.-release freeswitch-$switch_version
cd /usr/src/freeswitch-$switch_version

# enable required modules
sed -i /usr/src/freeswitch-$switch_version/modules.conf -e s:'#applications/mod_callcenter:applications/mod_callcenter:'
sed -i /usr/src/freeswitch-$switch_version/modules.conf -e s:'#applications/mod_cidlookup:applications/mod_cidlookup:'
sed -i /usr/src/freeswitch-$switch_version/modules.conf -e s:'#applications/mod_memcache:applications/mod_memcache:'
sed -i /usr/src/freeswitch-$switch_version/modules.conf -e s:'#applications/mod_curl:applications/mod_curl:'
sed -i /usr/src/freeswitch-$switch_version/modules.conf -e s:'#formats/mod_shout:formats/mod_shout:'
sed -i /usr/src/freeswitch-$switch_version/modules.conf -e s:'#formats/mod_pgsql:formats/mod_pgsql:'
sed -i /usr/src/freeswitch-$switch_version/modules.conf -e s:'endpoints/mod_verto:#endpoints/mod_verto:'

#disable module or install dependency libks to compile signalwire
sed -i /usr/src/freeswitch-$switch_version/modules.conf -e s:'applications/mod_signalwire:#applications/mod_signalwire:'

# prepare the build
./configure -C --enable-portable-binary --disable-dependency-tracking \
--prefix=/usr --localstatedir=/var --sysconfdir=/etc \
--with-openssl --enable-core-pgsql-support

# compile and install
make
make install

#return to the executing directory
cd $CWD
