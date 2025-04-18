#!/bin/bash

# Get current volume
current_volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%')

case $1 in
    raise)
        # Increase volume by 5%
        pactl set-sink-volume @DEFAULT_SINK@ +5%
        # Limit maximum volume to 100%
        if [ "$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%')" -gt 100 ]; then
            pactl set-sink-volume @DEFAULT_SINK@ 100%
        fi
        ;;
    lower)
        # Decrease volume by 5%
        pactl set-sink-volume @DEFAULT_SINK@ -5%
        # Prevent volume from going below 0%
        if [ "$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%')" -lt 0 ]; then
            pactl set-sink-volume @DEFAULT_SINK@ 0%
        fi
        ;;
    *)
        # Display usage instructions
        echo "Usage: $0 {raise|lower}"
        exit 1
        ;;
esac

