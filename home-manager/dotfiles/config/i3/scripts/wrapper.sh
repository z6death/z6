#!/bin/bash

# Explicit PATH for running under i3bar
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Absolute path to jq - adjust if different on your system
JQ="/usr/bin/jq"

# Colors
WHITE="#ffffff"
BLACK="#000000"
GREEN="#00ff00"
SEPARATOR=""  # Powerline symbol

# Start i3status and enhance its output
i3status | while read -r line; do
    # Print header lines unchanged
    if [[ "$line" =~ ^\{ ]] || [[ "$line" =~ ^\[ ]]; then
        echo "$line"
        continue
    fi

    # Strip leading and trailing square brackets
    line=${line#[}
    line=${line%]}

    # Parse blocks with jq
    blocks=$(echo "$line" | $JQ -c '.[]')

    out="["
    bg="$GREEN"
    fg="$BLACK"

    for block in $blocks; do
        # Escape quotes in full_text to keep JSON valid
        text=$(echo "$block" | $JQ -r '.full_text' | sed 's/"/\\"/g')

        # Separator with fg = next bg, bg = current bg (Powerline style)
        out+="{\"full_text\":\"$SEPARATOR\",\"color\":\"$fg\",\"background\":\"$bg\"},"

        # Block itself with white text on bg
        out+="{\"full_text\":\" $text \",\"color\":\"$WHITE\",\"background\":\"$bg\"},"

        # Swap colors for next block
        tmp=$bg
        bg=$fg
        fg=$tmp
    done

    # Remove trailing comma and close JSON array
    out="${out%,}]"
    echo "$out"
done
