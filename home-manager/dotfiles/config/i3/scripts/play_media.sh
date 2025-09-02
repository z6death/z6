#!/bin/bash

while true; do
    FILE=$(find ~/Music/ -type f \( -iname "*" -o -iname "*.mp3" \) | sort | rofi -dmenu -p "Select audio")

    # Exit if nothing selected
    [ -z "$FILE" ] && break

    # Play audio (even from .mp4) with no video window
    cvlc --no-video --play-and-exit "$FILE"
done
