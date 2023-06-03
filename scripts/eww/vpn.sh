#!/bin/bash

OUTPUT="$(nmcli -f type connection show --active | tail +2 | grep tun)"

if [ -z "$OUTPUT" ]; then
    echo "󰱟"
else
    echo "󰱔"
fi

