#!/bin/bash
# Fedora 26
#

mkdir ~/temp/
cd ~/temp/

sudo dnf install rxvt rxvt-unicode rxvt-unicode256color kernel-devel ccze awesome fontawesome-fonts liberation-fonts sqlite

# atom.io      ( Get latest relase from github )
wget https://github.com/atom/atom/releases/download/v1.21.1/atom.x86_64.rpm
sudo rpm -i ./atom.x86_64.rpm

# For ls++
dnf install perl-Storable
cpan Test::More
cpan Term::ExtendedColor

# firejail src
git clone https://github.com/netblue30/firejail.git ~/temp/firejail/
cd firejail/
./configure && make
sudo make install-strip

# YouCompleteMe for VIM
sudo dnf install automake gcc gcc-c++ kernel-devel cmake python-devel python3-devel
cd ~/.vim/bundle/
git clone https://github.com/Valloric/YouCompleteMe
cd YouCompleteMe
git submodule update --init --recursive
./install.py
cd ~/temp/

cd ~
