#!/bin/bash
set -eu

if ! grep -q "vm.max_map_count=262144" /etc/sysctl.conf; then
	echo "Updating max_map_count in sysctl"
	echo "vm.max_map_count=262144" >>/etc/sysctl.conf
fi

sysctl -p
