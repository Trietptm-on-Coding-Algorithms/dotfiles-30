#!/bin/bash

# Installs configuration files and creates the requried auth file for openvpn
crypto_token = "0000-0000-0000-0000"

if [ ! -d /etc/openvpn/ ]; then
    mkdir /etc/openvpn/
fi

echo "[*] Creating auth file with key: $crypto_token"
touch auth
echo "$crypto_token\n$crypto_token" > auth # Need 2 rows (auth/pass)

if [[ ! -f /etc/openvpn/norway.ovpn && ! -f /etc/openvpn/auth ]]; then
    echo "[*] Copying config files to /etc/openvpn/"
    cp norway.ovpn /etc/openvpn/
    cp auth /etc/openvpn/
else
    echo "[EE] norway.ovpn or/and auth file already exists. Canceling..."
    exit
fi

rm auth
echo "[*] Done..."
