#!/bin/sh

set -e

echo "Copying zone files to /var/bind"
mkdir -p /var/bind
cp -a /var/cache/bind/zones/. /var/bind/

echo "Copying over named.conf.local"
cp -rf /var/cache/bind/config/named.conf.local /etc/bind

echo "Changing owner to named user"
mkdir -m 0775 -p /var/run/named
chown -R bind:bind /var/bind /etc/bind /var/run/named /var/log/named
chmod -R o-rwx /var/bind /etc/bind /var/run/named /var/log/named

START_UP=$(which named)
echo "Starting bind at $START_UP -u bind -c /etc/bind/named.conf -f"

exec $(which named) -u bind -c /etc/bind/named.conf -f
