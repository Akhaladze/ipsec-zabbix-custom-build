#!/bin/bash
mac=$(cat /sys/class/net/eth0/address | tr -d ':')
random=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 6)
client_id="node-${mac}-${random}"

if [ ! -f /etc/ipsec.conf ]; then
    exit 1
fi

#sed -i '/^conn myvpn/,/^conn /{s/^leftid=.*//}' /etc/ipsec.conf
sed -i '/left=%any/a leftid='"${client_id}"'' /etc/ipsec.conf

#ipsec restart

#tail -f /dev/null
