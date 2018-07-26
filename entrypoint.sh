#!/bin/sh

set -e

echo "Copying zone files to /var/bind"
cp -rf /var/cache/bind/zones/* /var/bind

echo "Copying over named.conf.local"
cp -rf /var/cache/bind/config/named.conf.local /etc/bind

echo "Changing owner to named user"
chown -R named:named /var/bind /etc/bind /var/run/named /var/log/named
chmod -R o-rwx /var/bind /etc/bind /var/run/named /var/log/named

START_UP=$(which named)
echo "Starting bind at $START_UP -u named -c /etc/bind/named.conf -f"

exec $(which named) -u named -c /etc/bind/named.conf -f
