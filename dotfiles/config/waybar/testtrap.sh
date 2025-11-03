#!/usr/bin/env bash

function fire() {
    notify-send "hey!" "the event got fired"
}

trap fire SIGRTMIN+5

while read -r line; do
    # echo "{\"text\": \"Entry : $line\"}"
    :
done < <(tail -f /dev/null)
