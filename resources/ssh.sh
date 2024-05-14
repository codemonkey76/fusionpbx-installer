#!/bin/sh
# Move to script directory, so relative paths work
cd "$(dirname "$0")"

# Includes
. ./config.sh
. ./colors.sh
. ./environment.sh

verbose "Configuring SSH"
mkdir -p /home/$system_username/.ssh
wget -O - https://raw.githubusercontent.com/codemonkey76/authorized_keys/main/authorized_keys >> /home/$system_username/.ssh/authorized_keys
chmod 400 /home/$system_username/.ssh/authorized_keys
chown -R $system_username:$system_username /home/$system_username/.ssh
