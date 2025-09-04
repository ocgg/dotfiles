#!/bin/bash

function array_join {
  local d=${1-} f=${2-}
  if shift 2; then
    printf %s "$f" "${@/#/$d}"
  fi
}

MENU_ENTRIES=(
" Check git"
" Suspend"
"󰥿 Suspend & lock"
" Logout"
" Shutdown"
" Reboot"
" Lock"
)
MENU_LENGTH=${#MENU_ENTRIES[@]}
MENU_STR=$(array_join "," "${MENU_ENTRIES[@]}")

ROFI_THEME_STR="
listview { scrollbar: false; }
window { width: 15em; }
"

ACTION=$(
    echo "$MENU_STR" | rofi\
        -sep ","\
        -dmenu\
        -l "$MENU_LENGTH"\
        -p "action"\
        -theme-str "$ROFI_THEME_STR"
)

case "$ACTION" in
    " Check git")      kitty -e ~/.config/hypr/cgc;;
    " Logout")         loginctl terminate-user "$USER";;
    " Suspend")        systemctl suspend;;
    " Shutdown")       systemctl poweroff;;
    " Reboot")         systemctl reboot;;
    "󰥿 Suspend & lock") systemctl suspend && hyprlock;;
    " Lock")           hyprlock;;
    *)                  notify-send "shutdown-menu" "Not found: $ACTION";;
esac
