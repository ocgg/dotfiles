#!/bin/bash

MENU="\
 Check git,\
 Suspend,\
 Logout,\
 Shutdown,\
 Reboot,\
 Lock\
"

THEME_STR="
listview { scrollbar: false; }
window { width: 15em; }
"

ACTION=$(echo "$MENU" | rofi -sep "," -dmenu -l 6 -i -p "action" -theme-str "$THEME_STR" )

case "$ACTION" in
    " Check git")  kitty -e ~/.config/hypr/cgc;;
    " Suspend")    systemctl suspend && hyprlock;;
    " Logout")     loginctl terminate-user "$USER";;
    " Shutdown")   systemctl poweroff;;
    " Reboot")     systemctl reboot;;
    " Lock")       hyprlock;;
esac
