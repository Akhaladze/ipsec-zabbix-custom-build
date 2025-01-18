#!/bin/bash

# Entrypoint script to run only on the first container creation
# Ensure this script exits on error
set -e

# Step 1: Obtain interface name
INTERFACES=("eth0" "ensp0s1")
FOUND_INTERFACE=""
for IFACE in "${INTERFACES[@]}"; do
    if ip link show "$IFACE" &>/dev/null; then
        FOUND_INTERFACE="$IFACE"
        break
    fi
done

if [ -z "$FOUND_INTERFACE" ]; then
    echo "Error: No valid interface found. Exiting."
    exit 1
fi

# Step 2: Get the MAC address of the interface
MAC=$(cat /sys/class/net/$FOUND_INTERFACE/address | tr '[:lower:]' '[:upper:]' | sed 's/:/-/g')
NODE_NAME="node-$MAC"

# Step 3: Update /etc/ipsec.conf
IPSEC_CONF="/etc/ipsec.conf"
if [ -f "$IPSEC_CONF" ]; then
    sed -i "s/leftid=%any/leftid=$NODE_NAME/" "$IPSEC_CONF"
else
    echo "Warning: $IPSEC_CONF not found. Skipping."
fi

# Step 4: Update /etc/zabbix/zabbix_agentd.conf
ZABBIX_CONF="/etc/zabbix/zabbix_agentd.conf"
if [ -f "$ZABBIX_CONF" ]; then
    sed -i "s/^Server=.*/Server=66.135.8.5/" "$ZABBIX_CONF"
    sed -i "s/^ServerActive=.*/ServerActive=66.135.8.5/" "$ZABBIX_CONF"
    sed -i "s/^# HostnameItem=.*/HostnameItem=$NODE_NAME/" "$ZABBIX_CONF"
else
    echo "Warning: $ZABBIX_CONF not found. Skipping."
fi

# Step 5: Change system hostname
echo "$NODE_NAME" > /etc/hostname
hostnamectl set-hostname "$NODE_NAME"

echo "Configuration changes applied successfully."
