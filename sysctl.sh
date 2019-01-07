#!/bin/bash
set -eu

echo "Updating sysctl"
if ! grep -q "vm.max_map_count=262144" /etc/sysctl.conf; then
	echo "vm.max_map_count=262144" >>/etc/sysctl.conf
fi

sysctl -p
