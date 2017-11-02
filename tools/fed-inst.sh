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

# Harden FF user.js
sudo wget https://raw.githubusercontent.com/pyllyukko/user.js/master/user.js /etc/firefox/


# Security settings

#Turn on ASLR Conservative Randomization
sysctl -w kernel.randomize_va_space=1
#Hide Kernel Pointers
sysctl -w kernel.kptr_restrict=1
#Allow reboot/poweroff, remount read-only, sync command
sysctl -w kernel.sysrq=176
#Restrict PTRACE for debugging
sysctl -w kernel.yama.ptrace_scope=1
#Hard and Soft Link Protection
sysctl -w fs.protected_hardlinks=1
sysctl -w fs.protected_symlinks=1
#Enable TCP SYN Cookie Protection
sysctl -w net.ipv4.tcp_syncookies=1
#Disable IP Source Routing
sysctl -w net.ipv4.conf.all.accept_source_route=0

#Disable ICMP Redirect Acceptance
sysctl -w net.ipv4.conf.all.accept_redirects=0
sysctl -w net.ipv6.conf.all.accept_redirects=0
sysctl -w net.ipv4.conf.all.send_redirects=0
sysctl -w net.ipv6.conf.all.send_redirects=0

#Enable IP Spoofing Protection
sysctl -w net.ipv4.conf.all.rp_filter=1
sysctl -w net.ipv4.conf.default.rp_filter=1

#Enable Ignoring to ICMP Requests
sysctl -w net.ipv4.icmp_echo_ignore_all=1
#Enable Ignoring Broadcasts Request
sysctl -w net.ipv4.icmp_echo_ignore_broadcasts=1
#Enable Bad Error Message Protection
sysctl -w net.ipv4.icmp_ignore_bogus_error_responses=1

sysctl -p
