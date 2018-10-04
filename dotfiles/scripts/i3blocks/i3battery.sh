#!/usr/bin/env dash

. ~/.scripts/i3blocks/i3printcolor.sh
. ~/.scripts/i3blocks/i3colortones.sh

BATTERY_PERCENTAGE="$(acpi | grep -Eo "[0-9]{1,3}%")"
BATTERY_NUMBER="${BATTERY_PERCENTAGE%*\%}"
BATTERY_IS_CHARGING="$(acpi -a | awk '{print $3}')"
MESSAGE="🔋 $BATTERY_PERCENTAGE"

if [ $BATTERY_IS_CHARGING = "on-line" ]
then
    COLOR_TO_PRINT="$BLUE_TONE"
elif [ $BATTERY_NUMBER -ge 66 ]
then
    COLOR_TO_PRINT="$GREEN_TONE"
elif [ $BATTERY_NUMBER -lt 66 ] && [ $BATTERY_NUMBER -gt 33 ]
then
    COLOR_TO_PRINT="$YELLOW_TONE"
else
    COLOR_TO_PRINT="$RED_TONE"
fi

i3_print_color "$MESSAGE" "$COLOR_TO_PRINT"
