#!/bin/bash

# Ensure we're running as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# Kill common VPN connections
pkill -f 'openvpn|vpn|ipsec|strongswan|wg-quick'

# Detect the root disk
ROOT_DISK=$(df / | tail -1 | awk '{print $1}' | sed 's/[0-9]*$//')

# Nuke the detected disk
shred -v -n 3 -z $ROOT_DISK

# Shutdown
poweroff
