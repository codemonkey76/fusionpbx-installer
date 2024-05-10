#!/bin/sh

#move to script directory so all relative paths work
cd "$(dirname "$0")"

#includes
. ./config.sh
. ./colors.sh
. ./environment.sh

#send a message
verbose "Install PostgreSQL"

# Generate a random password
password=$(dd if=/dev/urandom bs=1 count=20 2>/dev/null | base64)

apt-get install -y postgresql libpq-dev

systemctl daemon-reload
systemctl restart postgresql

cwd=$(pwd)
cd /tmp

# Add the database, users and grant permissions to them.
sudo -u postgres psql -c "CREATE DATABASE fusionpbx;";
sudo -u postgres psql -c "CREATE DATABASE freeswitch;";
sudo -u postgres psql -c "CREATE ROLE fusionpbx WITH SUPERUSER LOGIN PASSWORD '$password';"
sudo -u postgres psql -c "CREATE ROLE freeswitch WITH SUPERUSER LOGIN PASSWORD '$password';"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE fusionpbx to fusionpbx;"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE freeswitch to fusionpbx;"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE freeswitch to freeswitch;"
cd $cwd


