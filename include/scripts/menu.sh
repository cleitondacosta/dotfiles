THEMES_DIR="$HOME/.include/rofi-themes"

menu_select_item() {
    printf '%s\n' "$@" | _menu "option-list-theme.rasi"
}

menu_yes_or_no() {
    echo -e "yes\nno" | _menu "prompt-theme.rasi" "$1"\
        | tr -s 'yes' 1\
        | tr -s 'no' 0
}

menu_input() {
    _menu "input-theme.rasi" "$1"
}

_menu() {
    local theme="$1"
    local prompt="$2"

    rofi -theme "$THEMES_DIR/$theme" -dmenu -p "$2" -no-custom
}
