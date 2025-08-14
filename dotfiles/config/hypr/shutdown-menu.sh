#!/bin/bash

MENU="\
 Check git,\
 Suspend,\
󰥿 Suspend & lock,\
 Logout,\
 Shutdown,\
 Reboot,\
 Lock\
"

THEME_STR="
listview { scrollbar: false; }
window { width: 15em; }
"

ACTION=$(echo "$MENU" | rofi -sep "," -dmenu -l 7 -i -p "action" -theme-str "$THEME_STR" )

case "$ACTION" in
    " Check git")          kitty -e ~/.config/hypr/cgc;;
    " Logout")             loginctl terminate-user "$USER";;
    " Suspend")            systemctl suspend;;
    " Shutdown")           systemctl poweroff;;
    " Reboot")             systemctl reboot;;
    "󰥿 Suspend & lock")     systemctl suspend && hyprlock;;
    " Lock")               hyprlock;;
esac
