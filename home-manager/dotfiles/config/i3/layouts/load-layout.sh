#!/bin/bash

LAYOUT_DIR="$HOME/.config/i3/layouts"

# Let user pick a layout
LAYOUT_NAME=$(ls "$LAYOUT_DIR"/*.json 2>/dev/null | sed 's|.*/||; s|\.json$||' | rofi -dmenu -p "Choose layout")
[ -z "$LAYOUT_NAME" ] && exit

LAYOUT_PATH="$LAYOUT_DIR/${LAYOUT_NAME}.json"

# Get list of used workspace numbers
USED=$(i3-msg -t get_workspaces | jq '.[].num')

# Find next unused number
for i in $(seq 1 20); do
    if ! echo "$USED" | grep -q -w "$i"; then
        NEXT_WS="$i"
        break
    fi
done

# If none found, default to 21
: "${NEXT_WS:=21}"

# Switch to next empty workspace and load layout
i3-msg "workspace number $NEXT_WS"
i3-msg "append_layout $LAYOUT_PATH"
