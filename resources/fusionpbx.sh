#!/bin/sh

# Move to script directory, so all relative paths work
cd "$(dirname "$0")"

# Includes
. ./config.sh
. ./colors.sh

verbose "Installing FusionPBX"

mkdir -p /var/cache/fusionpbx
chown -R www-data:www-data /var/cache/fusionpbx

git clone https://github.com/fusionpbx/fusionpbx.git /var/www/fusionpbx
chown -R www-data:www-data /var/www/fusionpbx
