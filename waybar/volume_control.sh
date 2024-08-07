#!/bin/bash

# Get current volume
current_volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%')

case $1 in
    raise)
        # Raise volume by 5%
        pactl set-sink-volume @DEFAULT_SINK@ +5%
        # Ensure the volume doesn't exceed 100%
        if [ "$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%')" -gt 100 ]; then
            pactl set-sink-volume @DEFAULT_SINK@ 100%
        fi
        ;;
    lower)
        # Lower volume by 5%
        pactl set-sink-volume @DEFAULT_SINK@ -5%
        # Ensure the volume doesn't go below 0%
        if [ "$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%')" -lt 0 ]; then
            pactl set-sink-volume @DEFAULT_SINK@ 0%
        fi
        ;;
    mute)
        # Toggle mute
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        ;;
    *)
        echo "Usage: $0 {raise|lower|mute}"
        exit 1
        ;;
esac
