#!/bin/bash
set -eu

VERSION="0.13.0"
if [ ! -z "$1" ]; then
  VERSION=$1
fi

INSTALLED=""
if [ -f "/usr/local/bin/docker-compose" ]; then
  INSTALLED=$(docker-compose -v | grep "version $VERSION")
fi

if [ -z "$INSTALLED" ]; then
  echo "Installing docker-machine v$VERSION"
  curl --silent -L https://github.com/docker/machine/releases/download/v$VERSION/docker-machine-$(uname -s)-$(uname -m) >/usr/local/bin/docker-machine &&
    chmod +x /usr/local/bin/docker-machine
fi
docker-machine -v
