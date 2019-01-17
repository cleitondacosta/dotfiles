#!/usr/bin/env dash

ROFI_THEME=~/.dotfiles/dotfiles/rofi-themes/dmenu-dropdown-theme.rasi

ARTIST_DIR="$(ls ~/music | rofi -dmenu -i -theme $ROFI_THEME)"

if [ -z "$ARTIST_DIR" ]
then
    exit 0
fi

ALBUM="$(ls ~/music/$ARTIST_DIR | rofi -dmenu -i -theme $ROFI_THEME)"

if [ -z "$ALBUM$ARTIST_DIR" ]
then
    exit 0
fi

mpc clear && mpc add "$ARTIST_DIR/$ALBUM"\
    && mpc play && pkill -RTMIN+10 i3blocks
