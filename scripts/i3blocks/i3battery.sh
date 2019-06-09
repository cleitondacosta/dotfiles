#!/usr/bin/env dash

BATTERY_PERCENTAGE="$(acpi | grep -Eo "[0-9]{1,3}%")"
echo $BATTERY_PERCENTAGE
