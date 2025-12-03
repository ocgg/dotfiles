#!/usr/bin/env bash

set -euo pipefail

ROFI_THEME_STR="listview{scrollbar:false;} window{location:north; anchor:north; y-offset:0; width:20em;}"
TASKS_FILE="$HOME/.config/waybar/little-reminder/tasks.txt"

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

function add() {
    tasks_nb="$(wc -l "$TASKS_FILE")"
    task=$(cat "$TASKS_FILE" | rofi -dmenu -theme-str "$ROFI_THEME_STR" -l "$tasks_nb" -p "Note" &)
    if [ -z "$task" ]; then
        return
    elif ! grep -Fxq "$task" "$TASKS_FILE"; then
        echo "$task" >> "$TASKS_FILE"
    fi
    print_output "$task"
}

function delete() {
    tasks_nb="$(wc -l "$TASKS_FILE")"
    task=$(cat "$TASKS_FILE" | rofi -dmenu -theme-str "$ROFI_THEME_STR" -l "$tasks_nb" -p "DELETE" &)
    if [ -z "$task" ]; then
        return
    elif grep -Fxq "$task" "$TASKS_FILE"; then
        # TODO: crash when deleting last item
        grep -Fxv "$task" "$TASKS_FILE" > "$TASKS_FILE.tmp" && mv "$TASKS_FILE.tmp" "$TASKS_FILE"
    fi
}

function reset() {
    print_output ""
}

reset # initial state

trap add SIGRTMIN+5
trap delete SIGRTMIN+6
trap reset SIGRTMIN+7

while read -r; do :
done < <(tail -f /dev/null)
