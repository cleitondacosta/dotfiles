#!/bin/bash

OUTPUT="$(nmcli -f type connection show --active | tail +2 | grep tun)"
isVpnActive="$(echo -n $(eww get isVpnActive))"

if [ -z "$OUTPUT" ]; then
    eww update "isVpnActive=false"
    if [ $isVpnActive = "true" ]; then
        eww close vpn
        eww close vpn2
    fi
    echo "󰱟"
else
    eww update "isVpnActive=true"
    if [ $isVpnActive = "false" ]; then
        eww open vpn
        eww open vpn2
    fi
    echo "󰱔"
fi

