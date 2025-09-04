#!/bin/bash

function array_join {
  local d=${1-} f=${2-}
  if shift 2; then
    printf %s "$f" "${@/#/$d}"
  fi
}

MENU_ENTRIES=(
"󱙓 Search note"
"󰮲 Show last note"
"󱞁 Edit note"
"󰎜 New note"
"󱙑 Delete note"
"󰎞 Show raw note"
"󰺿 Show quicknotes"
# "󱘓 Add quicknote"
"󱓩 Edit quicknote"
" cd notes dir"
)

declare -A ENTRY_TO_CMD=(
    ["󱙓 Search note"]="nuts | less"
    ["󰮲 Show last note"]="nuts last | less"
    ["󱞁 Edit note"]="nuts edit"
    ["󰎜 New note"]="nuts new"
    ["󱙑 Delete note"]="nuts delete"
    ["󰎞 Show raw note"]="nuts raw | less"
    ["󰺿 Show quicknotes"]="nuts quick | less"
    # ["󱘓 Add quicknote"]="nuts mldkfdkjfhkjfdhqf"
    ["󱓩 Edit quicknote"]="nuts edit quicknotes"
    [" cd notes dir"]="cd ~/notes && exec $SHELL"
)

MENU_LENGTH=${#MENU_ENTRIES[@]}
MENU_STR=$(array_join "," "${MENU_ENTRIES[@]}")

ROFI_THEME_OPTS="
window { width: 15em; }
listview { scrollbar: false; }
"

ENTRY=$(
    echo "$MENU_STR"\
    | rofi -i\
        -dmenu\
        -sep ","\
        -l "$MENU_LENGTH"\
        -p "nuts"\
        -theme-str "$ROFI_THEME_OPTS"
)

[ "$ENTRY" = "" ] && exit

# Should never happen
if [[ ! -v ENTRY_TO_CMD["$ENTRY"] ]]; then
    notify-send "nuts-menu" "ERROR: entry does not exist."
    exit 1
fi

kitty -e "$SHELL" -i -c "echo; ${ENTRY_TO_CMD["${ENTRY}"]}"
