#!/bin/bash

FILE=/etc/default/grub
VAR="GRUB_CMDLINE_LINUX"
VALUE="cgroup_enable=memory swapaccount=1"
if ! grep -q "$VAR" $FILE; then
	echo "Adding $VAR"
	echo "$VAR=\"$VALUE\"" >>$FILE
else
	echo "Updating $VAR with $VALUE"
	perl -pi -e "s|^$VAR=.*\n||" $FILE
	echo "$VAR=\"$VALUE\"" >>$FILE
fi
sudo update-grub2
