source "$HOME/.include/script/rice_file.sh"

menu_show_list() {
    printf '%s\n' "$@"\
    | _rofi "option-list-theme.rasi"
}

menu_select_item() {
    printf '%s\n' "$@"\
    | _rofi "option-list-theme.rasi"
}

menu_input() {
    _rofi "type-theme.rasi" "$1"
}

_rofi() {
    local theme="$1"
    local prompt="$2"

    rofi -theme "$ROFI_THEMES_DIR/$theme" -dmenu -p "$2" -no-custom
}
