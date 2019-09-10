#!/usr/bin/env bash

case "$BLOCK_BUTTON" in
  1|2|3) 
    DIMENSIONS="$(xdpyinfo | grep dimensions | awk '{print $2}')"
    SCREEN_WIDTH="$(echo "$DIMENSIONS" | cut -d'x' -f1)"
    SCREEN_HEIGHT="$(echo "$DIMENSIONS" | cut -d'x' -f2)"

	POS_X=$(($SCREEN_WIDTH - $WIDTH-21))
    POS_Y=$(($I3BLOCKS_HEIGHT + 1))

	i3-msg -q "exec yad --calendar \
        --width=$WIDTH --height=$HEIGHT \
	    --undecorated --fixed \
	    --close-on-unfocus --no-buttons \
	    --posx=$POS_X --posy=$POS_Y \
	    > /dev/null"
esac

echo "$(date "+%H:%M:%S")"
