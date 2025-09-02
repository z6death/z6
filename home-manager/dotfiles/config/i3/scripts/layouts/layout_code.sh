#!/bin/bash

# Workspace limit range
min_ws=1
max_ws=10

# Get the list of active workspace numbers
active_ws_nums=($(i3-msg -t get_workspaces | jq -r '.[].num'))

# Function to check if workspace is empty (has no windows)
is_empty_ws() {
    local ws_num=$1
    # Count windows in this workspace
    win_count=$(i3-msg -t get_tree | jq --argjson ws "$ws_num" '[recurse(.nodes[]?) | select(.type=="con" and .window!=null and .workspace.num == $ws)] | length')
    [[ "$win_count" -eq 0 ]]
}

# 1) Check 1-10 for an empty workspace
empty_ws=""
for ws in $(seq $min_ws $max_ws); do
    if [[ " ${active_ws_nums[*]} " =~ " $ws " ]]; then
        if is_empty_ws "$ws"; then
            empty_ws=$ws
            break
        fi
    else
        # Workspace not active yet (no windows) = empty
        empty_ws=$ws
        break
    fi
done

# 2) If no empty found, error out
if [[ -z "$empty_ws" ]]; then
    echo "No empty workspace available in range $min_ws-$max_ws."
    exit 1
fi

echo "Using workspace $empty_ws"

# Move to workspace and wait for focus
i3-msg "workspace number $empty_ws" >/dev/null
for i in {1..10}; do
    focused_ws=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).num')
    if [[ "$focused_ws" == "$empty_ws" ]]; then
        break
    fi
    sleep 0.1
done
if [[ "$focused_ws" != "$empty_ws" ]]; then
    echo "Failed to focus workspace $empty_ws"
    exit 1
fi

# Apply your layout (adjust path as needed)
i3-msg "append_layout /home/z6/.i3/code.json" >/dev/null &

# Launch apps with small delays
kitty --class=kitty -e hx &
sleep 0.4
kitty &
sleep 0.4
kitty --class=kitty -e cava &
sleep 0.4
kitty --class=kitty -e cvlc &

