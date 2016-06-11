#!/bin/bash

touch auth
echo $crypto_token > auth
echo $crypto_token >> auth
mkdir /etc/openvpn/
cp cstrom_linux-norway_udp.ovpn /etc/openvpn/
cp auth /etc/openvpn/
echo "Done..."
