#/usr/bin/env bash

FILENAME='hybrid-v35_64-nodebug-pcoem-6_30_223_271.tar.gz'

sudo rmmod wl
sudo dnf install gcc kernel-devel -y

if [ ! -d "wl/" ]; then
	mkdir wl
	cd wl
fi

if [ ! -f "$FILENAME" ]; then
    echo "...Downloading wl driver from broadcom.com"
    wget http://www.broadcom.com/docs/linux_sta/$FILE
fi

tar zxvf $FILENAME
make clean && make
sudo make install
sudo depmod -a
sudo rmmod b43 ssb bcma
sudo modprobe wl

printf 'blacklist b43\nblacklist ssb\nblacklist bcma\n' | sudo tee /etc/modprobe.d/wl.conf
echo 'wl' | sudo tee /etc/modules-load.d/wl.conf

echo "Done..."
