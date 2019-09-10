#!/usr/bin/env bash

GREY_COLOR="#606060"

i3_print_color() {
    TEXT="$1"
    COLOR="$2"

    echo "<span foreground=\"$COLOR\">$TEXT</span>"
}

CURRENT_MUSIC="$(mpc current --format "%artist%: %title%")"
MUSIC_STATE="$(mpc | grep -Eo "\[.+\]")"

case "$MUSIC_STATE" in
    "[paused]")
        i3_print_color "$CURRENT_MUSIC" "$GREY_COLOR" ;;

    "[playing]")
        echo "$CURRENT_MUSIC" ;;
esac
