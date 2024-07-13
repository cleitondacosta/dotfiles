#!/usr/bin/env dash
# Displays CPU Usage percentage and its temperature
# Dependencies: dash jq sysstat

TEMP="$(sensors -j | jq '."k10temp-pci-00c3"."Tctl"."temp1_input"' | xargs printf "%.0f")"
CPU_USAGE="$(mpstat 2 1 | tail -1 | awk '{print (100 - $12)"%"'})"

echo "$CPU_USAGE $TEMP°"
