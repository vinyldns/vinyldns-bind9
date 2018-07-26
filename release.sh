#!/bin/bash
set -ex

# ensure we're up to date
git pull
# bump version
version=`cat VERSION`
echo "version: $version"

# run build
./build.sh

# tag it
git add -A
git commit -m "version $version"
git tag -a "$version" -m "version $version"
git push
git push --tags

docker tag hub.docker.com/vinyldns/bind9:latest hub.docker.com/vinyldns/bind9:$version
docker push hub.docker.com/vinyldns/bind:latest
docker push hub.docker.com/vinyldns/bind:$version
