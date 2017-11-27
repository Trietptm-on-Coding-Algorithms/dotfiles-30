#!/bin/bash

# Montecarlo (http://bok.net/MonteCarl)
mkidr ~/gits/
cd ~/gits/
git clone https://aur.archlinux.org/montecarlo-font.git
cd montecarlo-font
makepkg -si

# FiraCode
for type in Bold Light Medium Regular Retina; do
    wget -O ~/.local/share/fonts/FiraCode-${type}.ttf \
    "https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-${type}.ttf?raw=true";
done


fc-cache -f > /dev/null
mkfontscale ~/.local/share/fonts/misc
mkfontdir ~/.local/share/fonts/misc
echo "Done..."
