#!/usr/bin/env dash

. ~/.scripts/i3blocks/i3printcolor.sh
. ~/.scripts/i3blocks/i3colortones.sh

IS_MUTED="$(pamixer --get-mute)"
VOLUME_NUMBER="$(pamixer --get-volume)"
EMOJI_MUTED_SOUND="🔇"
EMOJI_WITH_SOUND="🔊"

if [ -z "$IS_MUTED" ] || [ -z "$VOLUME_NUMBER" ]
then
    exit 1
fi

if [ "$IS_MUTED" = "true" ]
then
    echo "$EMOJI_MUTED_SOUND MUTED"
elif [ $VOLUME_NUMBER -eq 0 ]
then
    echo "$EMOJI_MUTED_SOUND 0%"
else
    if [ $VOLUME_NUMBER  -ge 66 ]
    then
        i3_print_color "$EMOJI_WITH_SOUND $VOLUME_NUMBER%" "$RED_TONE"
    else
        echo "$EMOJI_WITH_SOUND $VOLUME_NUMBER%"
    fi
fi
