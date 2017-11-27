#!/bin/sh

# Don't use special keys in $1. Use clean domain name as domain.com

usage="
 Usage:
	getwww [domain] [url]

	[domain] - Don't follow links from outside this domain
	[url]    - Don't follow links outside this directory.

	E.g: getwww domain.com domain.com/images/

"
if [ -z "$1" ]; then echo "$usage"; exit; fi
if [ -z "$2" ]; then echo "$usage"; exit; fi

wget --recursive --no-clobber --page-requisites --html-extension \
     --convert-links --restrict-file-names=windows --domains $1 \
     --no-parent $2

