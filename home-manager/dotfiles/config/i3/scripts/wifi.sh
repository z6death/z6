#!/bin/bash

while true; do
    # Get current active WiFi connection (if any)
    CURRENT_SSID=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)

    # Get list of WiFi networks (filter duplicates)
    SSIDS=$(nmcli -f SSID,SECURITY device wifi list --rescan yes | tail -n +2 | awk '{$1=$1; print}' | cut -d' ' -f1 | grep -v '^$' | sort -u)

    # Add Disconnect option
    MENU="Disconnect (current: ${CURRENT_SSID:-None})\n$SSIDS"

    # Let user pick with rofi
    CHOSEN_SSID=$(echo -e "$MENU" | rofi -dmenu -p "WiFi Networks")

    if [[ -z "$CHOSEN_SSID" ]]; then
        exit 0  # user cancelled
    fi

    if [[ "$CHOSEN_SSID" == Disconnect* ]]; then
        # Disconnect from current WiFi
        if [[ -n "$CURRENT_SSID" ]]; then
            nmcli connection down "$CURRENT_SSID" && \
                rofi -e "Disconnected from $CURRENT_SSID" || \
                rofi -e "Failed to disconnect"
        else
            rofi -e "No active WiFi to disconnect"
        fi
        continue
    fi

    # Ask for password with rofi
    PASSWORD=$(rofi -dmenu -p "Password for $CHOSEN_SSID" -password)

    # Try to connect
    if nmcli device wifi connect "$CHOSEN_SSID" password "$PASSWORD"; then
        rofi -e "Connected to $CHOSEN_SSID"
    else
        rofi -e "Failed to connect to $CHOSEN_SSID"
    fi

    sleep 1
done
