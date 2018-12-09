#!/usr/bin/env dash

# The command (first word) cannot have spaces.
# Good:
#   shutdown -h now
# Bad:
    # "~/my scripts/script to do something.sh" abc

STRING_SIZE_LIMIT=25
THIS_SCRIPT_NAME="rofi/prompt.sh"

rofi_error() {
    rofi -e "$THIS_SCRIPT_NAME: Error: $1"
}

if [ $# -ne 2 ]
then
    rofi_error " You passed $# args. Usage: prompt.sh ACTION COMMAND"
    exit 1
fi

ACTION="$1"
COMMAND="$2"

if [ ${#ACTION} -gt $STRING_SIZE_LIMIT ]
then
    rofi_error "$ACTION too long, limit its size to $STRING_SIZE_LIMIT."
    exit 1
fi

ANSWER=$(
    echo "Yes\nNo"\ | rofi -dmenu -i -p "Are you sure about $ACTION?"\
                      -theme ~/.dotfiles/dotfiles/rofi-themes/prompt-theme.rasi
)

command -v "${COMMAND%% *}" > /dev/null
if [ $? -ne 0 ]
then
    rofi_error "Command $COMMAND couldn't not found or couldn't be invoked."
    exit 1
fi

case "$ANSWER"
in
    Yes) $COMMAND ;;
    *) ;;
esac
