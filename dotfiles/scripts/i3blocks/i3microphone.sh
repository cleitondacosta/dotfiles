#!/usr/bin/env dash

. ~/.scripts/include/i3printcolor.sh
. ~/.scripts/include/i3colortones.sh

MICBOOST_PERCENTAGE=\
"$(amixer get "Mic Boost" | tail -1 | grep -Eo "[0-9]{1,3}%")"
MICBOOST_NUMBER="$(echo $MICBOOST_PERCENTAGE | grep -Eo "[0-9]{1,3}")"
MESSAGE="🎤 $MICBOOST_PERCENTAGE"

if [ $MICBOOST_NUMBER -ge 100 ]
then

    i3_print_color "$MESSAGE" "$RED_TONE"

elif [ $MICBOOST_NUMBER -ge 66 ] && [ $MICBOOST_NUMBER -lt 100 ]
then

    i3_print_color "$MESSAGE" "$YELLOW_TONE"

elif [ $MICBOOST_NUMBER -ge 33 ] && [ $MICBOOST_NUMBER -lt 66 ]
then

    i3_print_color "$MESSAGE" "$GREEN_TONE"

else

    echo "$MESSAGE"

fi
