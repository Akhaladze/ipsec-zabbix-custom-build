#!/bin/bash
mac=$(cat /sys/class/net/eth0/address | tr -d ':')
client_id="node-${mac}"
if [ ! -f /etc/ipsec.conf ]; then
    exit 1
fi
sed -i '/leftid=%any/a\  leftid='"${client_id}"'' /etc/ipsec.conf
