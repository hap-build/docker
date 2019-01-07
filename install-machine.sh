#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

DEFAULT_VERSION=0.16.0
VERSION=${1:-$DEFAULT_VERSION}

INSTALLED=""
if [ -f "/usr/local/bin/docker-compose" ]; then
	INSTALLED=$(docker-compose -v | grep "version $VERSION")
fi
if [ -z "$INSTALLED" ]; then
	echo "Installing docker-machine v$VERSION"
	binary=docker-machine-$(uname -s)-$(uname -m)
	curl --silent -L "https://github.com/docker/machine/releases/download/v$VERSION/$binary" >/usr/local/bin/docker-machine &&
		chmod +x /usr/local/bin/docker-machine
fi
docker-machine -v
