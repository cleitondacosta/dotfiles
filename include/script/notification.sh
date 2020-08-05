notification_send_success() {
    _notify "Success" "$1" "normal"
}

notification_send_warning() {
    _notify "Warning" "$1" "normal"
}

notification_send_error() {
    _notify "Error" "$1" "critical"
}

_notify() {
    local title="$1"
    local message="$2"
    local urgency="$3"

    notify-send -u "$urgency" "$title" "$message"
}
