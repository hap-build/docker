#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

DEFAULT_VERSION="18.06.1"
VERSION=${1-$DEFAULT_VERSION}

DOCKER_INSTALLED=$(command -v docker)
if [ -n "$DOCKER_INSTALLED" ]; then
	HAS_VERSION=$(docker --version | grep $VERSION)
	if [ -n "$HAS_VERSION" ]; then
		docker --version
		exit 0
	fi
fi

echo "Installing docker packages"
apt-get -y -qq update
apt-get -y -qq remove docker docker-engine docker.io containerd runc
apt-get -y -qq purge "docker*" "docker-engine*" "docker.io*" "lxc-docker*"
apt-get install -y -qq apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository \
	"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get -y -qq update
apt-get install -y -q docker-ce=$VERSION*

HAS_VERSION=$(docker --version | grep $VERSION)
if [ -z "$HAS_VERSION" ]; then
	echo "Docker $VERSION NOT installed. Please try again."
	exit 1
fi

if id ${USER} >/dev/null 2>&1; then
	echo "Add current user to docker group"
	sudo usermod -aG docker "$USER"
fi

echo "Restarting docker"
service docker stop || true
service docker start

docker --version
