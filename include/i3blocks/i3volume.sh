#!/usr/bin/env bash

IS_MUTED="$(pamixer --get-mute)"
VOLUME_NUMBER="$(pamixer --get-volume)"
EMOJI_MUTED_SOUND="🔇"
EMOJI_WITH_SOUND="🔊"

[[ "$IS_MUTED" = "true" ]]\
    && echo "$EMOJI_MUTED_SOUND MUTED"\
    || echo "$EMOJI_WITH_SOUND $VOLUME_NUMBER%"
