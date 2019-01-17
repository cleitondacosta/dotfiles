#!/usr/bin/env dash

. ~/.scripts/include/i3printcolor.sh
. ~/.scripts/include/i3colortones.sh

CURRENT_MUSIC="$(mpc current --format "%artist%: %title%")"
MUSIC_STATE="$(mpc | grep -Eo "\[.+\]")"

case "$MUSIC_STATE" in
    "[paused]")
        i3_print_color "$CURRENT_MUSIC" "$GREY_TONE" ;;

    "[playing]")
        echo "$CURRENT_MUSIC" ;;
esac
