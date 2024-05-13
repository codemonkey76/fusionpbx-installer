#!/bin/sh

# Move to script directory so that we can use relative paths
cd "$(dirname "$0")"

# Includes
. ./resources/config.sh
. ./resources/colors.sh
. ./resources/environment.sh

# Set timezone
timedatectl set-timezone $timezone

# Add dependencies
apt-get install -y wget
apt-get install -y lsb-release
apt-get install -y systemd
apt-get install -y systemd-sysv
apt-get install -y ca-certificates
apt-get install -y dialog
apt-get install -y nano

# SNMP
apt-get install -y snmpd
mkdir -p /etc/snmp/snmpd.conf.d
echo "rocommunity public" > /etc/snmp/snmpd.conf.d/rocommunity.conf
service snmpd restart

# IP Tables
resources/iptables.sh

# SNGrep
resources/sngrep.sh

# FusionPBX
resources/fusionpbx.sh

# PHP
resources/php.sh

# Nginx Web Server
resources/nginx.sh

# Postgresql
resources/postgresql.sh

# Freeswitch
resources/switch.sh

# Fail2ban
resources/fail2ban.sh

# Set the IP address
server_address=$(hostname -I)

# Add the database schema, users and groups
resources/finish.sh
