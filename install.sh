#!/bin/bash
set -eu

export DEBIAN_FRONTEND=noninteractive

VERSION=17.12.0-ce
DOCKER_INSTALLED=$(which docker)
if [ ! -z "$DOCKER_INSTALLED" ]; then
	HAS_VERSION=$(docker --version | grep $VERSION)
	if [ ! -z "$HAS_VERSION" ]; then
		echo "Docker $VERSION installed"
		exit 0
	fi
fi

echo "Installing packages"
apt-get -y -qq update
apt-get -y -q remove  docker docker-engine docker.io
apt-get -y -q purge "docker*" "docker-engine*" "docker.io*" "lxc-docker*"
apt-get install -y -q apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get -y -qq update
apt-get install -y -q docker-ce=${VERSION}

FILE=/etc/default/grub
VAR="GRUB_CMDLINE_LINUX"
VALUE="cgroup_enable=memory swapaccount=1"
if ! grep -q "$VAR" $FILE; then
	echo "Adding $VAR"
	echo "$VAR=\"$VALUE\"" >> $FILE
else
	echo "Updating $VAR with $VALUE"
	perl -pi -e "s|^$VAR=.*\n||" $FILE
	echo "$VAR=\"$VALUE\"" >> $FILE
fi
sudo update-grub2
ufw disable

if id ${USER} >/dev/null 2>&1; then
echo "Add ubuntu to docker group"
sudo usermod -aG docker ${USER}
sudo usermod -aG root ${USER}
fi

echo "Restarting docker"
service docker stop || true
service docker start

docker -v
