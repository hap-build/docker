#!/bin/bash
set -eu
export DEBIAN_FRONTEND=noninteractive
echo "Installing packages"
apt-get -y -qq update
apt-get -y -q install bridge-utils

VERSION="1.18.0"
if [ ! -z "$1" ]; then
  VERSION=$1
fi

INSTALLED=""
if [ -f "/usr/local/bin/docker-compose" ]l then
  INSTALLED=$(docker-compose -v | grep "version $VERSION")
fi

if [ -z "$INSTALLED" ]; then
echo "Installing docker-compose v$VERSION"
curl --silent -L https://github.com/docker/compose/releases/download/1.12.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
fi
docker-compose -v
