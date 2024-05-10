#!/bin/sh
# Move to script directory, so relative paths work
cd "$(dirname "$0")"

# Includes
. ./config.sh
. ./colors.sh
. ./environment.sh

# Send a message
verbose "Configuring PHP"

# Add the PHP repository
apt-get install -y software-properties-common ca-certificates lsb-release apt-transport-https
LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/nginx-mainline -y
apt-get update -y

# Install dependencies
apt-get install -y php php-cli php-fpm php-pgsql php-sqlite3 php-odbc php-curl php-imap php-xml php-gd php-mbstring
