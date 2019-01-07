#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

DEFAULT_VERSION=1.23.1
VERSION=${1:-$DEFAULT_VERSION}

INSTALLED=""
if [ -f "/usr/local/bin/docker-compose" ]; then
	INSTALLED=$(docker-compose -v | grep "version $VERSION")
fi
if [ -z "$INSTALLED" ]; then
	echo "Installing Docker Compose packages"
	apt-get -y -qq update
	apt-get -y -q install bridge-utils
	echo "Installing docker-compose v$VERSION"
	binary="docker-compose-$(uname -s)-$(uname -m)"
	curl --silent -L "https://github.com/docker/compose/releases/download/$VERSION/$binary" >/usr/local/bin/docker-compose
	chmod +x /usr/local/bin/docker-compose
fi
docker-compose -v
