#!/usr/bin/env bash

GREY_COLOR="#606060"

i3_print_color() {
    TEXT="$1"
    COLOR="$2"

    echo "<span foreground=\"$COLOR\">$TEXT</span>"
}

limit_string() {
    string="$1"

    [[ ${#string} -gt $MAX_CHARS ]]\
        && echo "${string:0:$MAX_CHARS}..."\
        || echo "${string:0:$MAX_CHARS}"
}

CURRENT_MUSIC="$(mpc current --format "%artist%: %title%")"
CURRENT_MUSIC_LIMITED="$(limit_string "$CURRENT_MUSIC")"
MUSIC_STATE="$(mpc | grep -Eo "\[.+\]")"

case "$MUSIC_STATE" in
    "[paused]")
        i3_print_color "$CURRENT_MUSIC_LIMITED" "$GREY_COLOR" ;;

    "[playing]")
        echo "$CURRENT_MUSIC_LIMITED" ;;
esac
