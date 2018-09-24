#!/bin/zsh
# requires: zsh, zenity, xclip

RGB="$(zenity --color-selection --title="Color Picker" 2>/dev/null)"

if [ $? -ne 0 ]
then
    exit 0
fi

RGB=( $(echo $RGB | grep -Eo "([0-9]{1,3},?){3}" | tr ',' '\n') )

HEX_COLOR="$(printf "#%2x%2x%2x" ${RGB[1]} ${RGB[2]} ${RGB[3]} | tr ' ' '0')"

printf "$HEX_COLOR" | xclip -selection clipboard

if [ $? -ne 0 ]
then
    zenity --error --text="Internal error"
    exit 1
fi
