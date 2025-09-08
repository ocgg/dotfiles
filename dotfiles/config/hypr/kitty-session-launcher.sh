#!/bin/bash
set -euo pipefail

NAME="Kitty session launcher"
# ROOT=$(dirname "$(realpath "$0")")
WORK_DIR="$HOME/code"
ROFI_THEME="window{ width:22em; }"
SESSION=""

main() {
    check_dependencies
    move_to_directory
    prepare_session
    launch_kitty_with_session && exit 0
}

check_dependencies() {
    for cmd in fd rofi kitty; do
        command -v "$cmd" || { notify-send "$NAME" "\nError: $cmd not found."; exit 1; }
    done
}

move_to_directory() {
    cd "$WORK_DIR"
    cd "$(select_in_list)"
}

select_in_list() {
    local selected
    selected=$(print_list | rofi -dmenu -p "$NAME" -theme-str "$ROFI_THEME")
    [ -z "$selected" ] && exit 0
    echo "$selected"
}

print_list() {
    fd -H -t dir --max-depth=3 "^\.git$" --strip-cwd-prefix -x dirname | sort
}

prepare_session() {
    if [ -f "bin/rails" ]; then
        prepare_rails_session
    else
        prepare_default_session
    fi
}

prepare_rails_session() {
    [ -f "bin/dev" ] && line launch --hold zsh -i -c dev
    [ -f "bin/jobs" ] && line launch --hold zsh -i -c bin/jobs
    line new_tab
    line launch nvim "$([ -f ocgg/session.vim ] && echo '-S ocgg/session.vim')"
    line focus
    line new_tab
}

prepare_default_session() {
    line launch --hold nvim
}

line() {
    SESSION+="$*\n"
}

launch_kitty_with_session() {
    echo -e "$SESSION" | kitty --session -
}

main
