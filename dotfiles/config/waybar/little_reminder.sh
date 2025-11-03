#!/usr/bin/env bash

STATE_FILE="/tmp/waybar_custom_task.json"
SIGNAL=10
ROFI_THEME_STR="listview{enabled:false;} window{location:north; anchor:north; y-offset:0; width:20em;}"

function print_output() {
    local text="$1"
    local json="{"
    if [ -n "$text" ]; then
        json+="\"text\": \"${text}\", \"class\": \"active\", \"alt\": \"active\""
    else
        json+='"alt": "inactive"' # for format-icon
    fi
    json+="}"
    echo "$json"
}

function write_in_file() {
    print_output "$1" > "$STATE_FILE"
}

case "$1" in
    "click")
        task=$(rofi -dmenu -theme-str "$ROFI_THEME_STR" -p "Note")
        write_in_file "$task"
        pkill -SIGRTMIN+$SIGNAL waybar
        ;;
    "show" )
        if [ -f "$STATE_FILE" ]; then
            cat "$STATE_FILE"
        else
            print_output
        fi
        ;;
    "reset" )
        write_in_file
        pkill -SIGRTMIN+$SIGNAL waybar
esac

