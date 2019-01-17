#!/usr/bin/env dash

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
else
    echo "$EMOJI_WITH_SOUND $VOLUME_NUMBER%"
fi
