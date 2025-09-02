#!/bin/bash

echo -n "Enter countdown time (e.g. 5m, 1h30m): "
read TIME

if [ -n "$TIME" ]; then
    termdown "$TIME"
    # After termdown finishes
    cvlc --no-video ~/Music/focus.mp3
    ~/.config/i3/scripts/termdown_input.sh
else
    echo "No time entered. Exiting..."
    sleep 2
fi
