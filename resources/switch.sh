#!/bin/sh

#move to script directory so all relative paths work
cd "$(dirname "$0")"

#includes
. ./config.sh

switch/source-release.sh
switch/source-sounds.sh
switch/conf-copy.sh
switch/package-permissions.sh
switch/package-systemd.sh
