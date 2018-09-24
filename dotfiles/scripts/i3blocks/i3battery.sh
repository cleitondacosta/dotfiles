#!/bin/sh

. ~/.scripts/i3blocks/i3printcolor.sh
. ~/.scripts/i3blocks/i3colortones.sh

BATTERY_PERCENTAGE="$(acpi | grep -Eo "[0-9]{1,3}%")"
BATTERY_NUMBER="$(echo "$BATTERY_PERCENTAGE" | grep -Eo "[0-9]{1,3}")"
MESSAGE="🔋 $BATTERY_PERCENTAGE"

if [ $BATTERY_NUMBER -ge 66 ]
then
    i3_print_color "$MESSAGE" "$GREEN_TONE"
elif [ $BATTERY_NUMBER -lt 66 ] && [ $BATTERY_NUMBER -gt 33 ]
then
    i3_print_color "$MESSAGE" "$YELLOW_TONE"
else
    i3_print_color "$MESSAGE" "$RED_TONE"
fi
