#!/bin/bash

# This enables non-root users to start Xorg
# (Tested with success on Fedora 23,24)

if [ ! -f /etc/X11/Xwrapper.config ]; then
	echo "[*] Creating config file with settings"
	sudo touch /etc/X11/Xwrapper.config
	sudo echo "needs_root_rights = no" > /etc/X11/Xwrapper.config
	echo "[*] $USERNAME: Becoming member of video and input group"
	sudo usermod -a -G video,input $USERNAME
else
	echo "[EE] Xwrapper.config already exists."
	exit
fi

echo "[*] Done..."
