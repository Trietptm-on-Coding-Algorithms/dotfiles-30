#!/bin/sh
sed -i \
         -e 's/#1e1b21/rgb(0%,0%,0%)/g' \
         -e 's/#d3d7cf/rgb(100%,100%,100%)/g' \
    -e 's/#1e1b21/rgb(50%,0%,0%)/g' \
     -e 's/#571107/rgb(0%,50%,0%)/g' \
     -e 's/#36323a/rgb(50%,0%,50%)/g' \
     -e 's/#d3d7cf/rgb(0%,0%,50%)/g' \
	*.svg