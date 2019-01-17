#!/usr/bin/env dash

BLUE_COLOR="#00e6ca"
YELLOW_COLOR="#D6FC00"
GREEN_COLOR="#71FC00"
RED_COLOR="#EF2C28"

i3_print_color()
{
    if [ $# -ne 2 ]
    then
        return 1
    fi

    TEXT="$1"
    COLOR="$2"

    echo "<span foreground=\"$COLOR\">$TEXT</span>"
    return 0
}

BATTERY_PERCENTAGE="$(acpi | grep -Eo "[0-9]{1,3}%")"
BATTERY_NUMBER="${BATTERY_PERCENTAGE%*\%}"
BATTERY_IS_CHARGING="$(acpi -a | awk '{print $3}')"

if [ $BATTERY_IS_CHARGING = "on-line" ]
then
    COLOR_TO_PRINT="$BLUE_COLOR"
elif [ $BATTERY_NUMBER -ge 66 ]
then
    COLOR_TO_PRINT="$GREEN_COLOR"
elif [ $BATTERY_NUMBER -lt 66 ] && [ $BATTERY_NUMBER -gt 33 ]
then
    COLOR_TO_PRINT="$YELLOW_COLOR"
else
    COLOR_TO_PRINT="$RED_COLOR"
fi

i3_print_color "$BATTERY_PERCENTAGE" "$COLOR_TO_PRINT"
