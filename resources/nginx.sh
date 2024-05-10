#!/bin/sh
# Move to script directory, so relative paths work
cd "$(dirname "$0")"

# Includes
. ./config.sh
. ./colors.sh
. ./environment.sh

# Send a message
verbose "Configuring NGINX"

apt-get install -y nginx
cp nginx/fusionpbx /etc/nginx/sites-available/fusionpbx
ln -s /etc/nginx/sites-available/fusionpbx /etc/nginx/sites-enabled/fusionpbx

# Self signed certificate
ln -s /etc/ssl/private/ssl-cert-snakeoil.key /etc/ssl/private/nginx.key
ln -s /etc/ssl/certs/ssl-cert-snakeoil.pem /etc/ssl/certs/nginx.crt

# Remove the default site
rm /etc/nginx/sites-enabled/default

# Update config if LetsEncrypt folder is unwanted
mkdir -p /var/www/letsencrypt/

# Flush systemd cache
systemctl daemon-reload

# Restart nginx
service nginx restart
