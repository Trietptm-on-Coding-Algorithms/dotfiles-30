#!/usr/bin/env bash
# Stolen from https://github.com/mathiasbynens/

function startInstall() {
  rsync --exclude ".git/" \
  --exclude "install.sh" \
  --exclude "LICENSE" \
  --exclude "README.md" \
  -avh -no-perms . ~;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	startInstall;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		startInstall;
	fi;
fi;
unset startInstall;
