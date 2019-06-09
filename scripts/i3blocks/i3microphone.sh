#!/usr/bin/env dash

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

MICBOOST_PERCENTAGE=\
"$(amixer get "Mic Boost" | tail -1 | grep -Eo "[0-9]{1,3}%")"
MICBOOST_NUMBER="$(echo $MICBOOST_PERCENTAGE | grep -Eo "[0-9]{1,3}")"

if [ $MICBOOST_NUMBER -ge 100 ]
then
    i3_print_color "$MICBOOST_PERCENTAGE" "$RED_COLOR"
elif [ $MICBOOST_NUMBER -ge 66 ] && [ $MICBOOST_NUMBER -lt 100 ]
then
    i3_print_color "$MICBOOST_PERCENTAGE" "$YELLOW_COLOR"
elif [ $MICBOOST_NUMBER -ge 33 ] && [ $MICBOOST_NUMBER -lt 66 ]
then
    i3_print_color "$MICBOOST_PERCENTAGE" "$GREEN_COLOR"
else
    echo "$MICBOOST_PERCENTAGE"
fi
