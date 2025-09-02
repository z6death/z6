#!/bin/bash

TOUCHPAD="SynPS/2 Synaptics TouchPad"

# Get current state (1 = enabled, 0 = disabled)
state=$(xinput list-props "$TOUCHPAD" | grep "Device Enabled" | awk '{print $4}')

if [ "$state" -eq 1 ]; then
    # Disable touchpad
    xinput disable "$TOUCHPAD"
    # Move cursor off-screen
    xdotool mousemove 9999 9999
    notify-send "Touchpad disabled, cursor hidden"
else
    # Enable touchpad
    xinput enable "$TOUCHPAD"
    # Get screen dimensions and move cursor to center
    screen_w=$(xdotool getdisplaygeometry | awk '{print $1}')
    screen_h=$(xdotool getdisplaygeometry | awk '{print $2}')
    xdotool mousemove $((screen_w / 2)) $((screen_h / 2))
    notify-send "Touchpad enabled, cursor visible"
fi
