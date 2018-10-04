i3_print_color()
{
    if [ $# -ne 2 ]
    then
        return 1
    fi

    TEXT="$1"
    COLOR="$2"

    echo "<span foreground=\"$COLOR\">$TEXT</span>"
    return 0
}
