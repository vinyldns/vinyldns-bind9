# vinyldns-bind9
![GitHub](https://img.shields.io/github/license/vinyldns/vinyldns-bind9)

Docker image for use with vinyldns.

This image _copies_ over configuration to the bind 9 image before starting the bind9 service.

The volume `/var/cache/bind/zones` contains your zone files.  These are copied onto the container to `/var/bind`

The volume `/var/cache/bind/config` should contain at least a single file `named.conf.local`.  All `named.conf.*` files in this directory are copied over to `/etc/bind` and will _replace_ the existing files of the same name.

> If you do not mount both, then the bind9 server may start up without any zones

To see how to use the image, look at the `docker-compose.yml` file.  It mounts the directories under `example`.

Simply run `docker-compose up -d` to load up the example.

Then you can test it out by running `dig @127.0.0.1 -p 5333 example.com`
