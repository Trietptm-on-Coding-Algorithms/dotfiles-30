#!/bin/bash

# Workfile...
# In progress... dont use!
echo "Not done... leaving!"
exit

if [ -f ~/gits/ ]; then mkdir ~/gits/ fi
echo "Using ~/gits/ as working directorie..."
echo "[*] merging packages..."
# ccze (logfile colorizer)
emerge --ask --quiet ccze dev-lang/go

echo "[*] installing ls++ and dependencies..."
if [ -f ~/gits/ls--/ ]; then rm -rf ~/gits/ls-- fi
sudo cpan Term::ExtendedColor
git clone https://github.com/trapd00r/ls-- ~/gits/
cd ~/gits/ls--/
perl Makefile.PL
make && sudo make install
cp ~/gits/ls--/ls++.conf ~/.ls++.conf

echo "[*] installing ccat"
go get -u github.com/jingweno/ccat
