#!/bin/sh
# Move to script directory, so relative paths work
cd "$(dirname "$0")"

# Includes
. ./config.sh
. ./colors.sh
. ./environment.sh

verbose "Configuring FusionPBX Theme"
rm -rf /var/www/fusionpbx/themes/default
git clone git@github.com:codemonkey76/fusionpbx-theme-asg.git /var/www/fusionpbx/themes/default


