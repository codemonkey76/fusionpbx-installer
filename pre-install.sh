#!/bin/sh

# Upgrade the packages
apt-get update && apt-get upgrade -y

# Install pre-requisite packages
apt-get install -y git

# Get the install script
cd /usr/src && git clone https://github.com/codemonkey76/fusionpbx-install.sh.git

# Change the working directory
cd /usr/src/fusionpbx-install.sh
