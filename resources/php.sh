#!/bin/sh
# Move to script directory, so relative paths work
cd "$(dirname "$0")"

# Includes
. ./config.sh
. ./colors.sh
. ./environment.sh

# Send a message
verbose "Configuring PHP"

# Install dependencies
apt-get install -y php8.3 php8.3-cli php8.3-fpm php8.3-pgsql php8.3-sqlite3 php8.3-odbc php8.3-curl php8.3-imap php8.3-xml php8.3-gd php8.3-mbstring
