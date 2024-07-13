#!/usr/bin/env dash
# Displays CPU Usage percentage and its temperature
# Dependencies: dash jq sysstat

CPU_TEMP="$(sensors -j | jq '."k10temp-pci-00c3"."Tctl"."temp1_input"' | xargs printf "%.0f")"
CPU_USAGE="$(mpstat 2 1 | tail -1 | awk '{print (100 - $12)""'})"

if [ $CPU_TEMP -ge 70 ] && [ $CPU_TEMP -lt 80 ]; then
    echo "{\"text\": \"  \\uf2db  $CPU_TEMP° $CPU_USAGE%  \", \"state\": \"warning\"}"
elif [ $CPU_TEMP -ge 80 ]; then
    echo "{\"text\": \"  \\uf2db  $CPU_TEMP° $CPU_USAGE%  \", \"state\": \"critical\"}"
else
    echo "{\"text\": \"\\uf2db  $CPU_TEMP° $CPU_USAGE%\", \"state\": \"idle\"}"
fi
