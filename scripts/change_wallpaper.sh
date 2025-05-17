#!/bin/bash

# Path to your wallpaper folder
WALLPAPER_DIR="/home/sidharth/walli/onlyarch/"

# Get a random wallpaper from the directory
wallpaper=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.bmp" -o -iname "*.gif" \) | shuf -n 1)

# Check if a wallpaper was found
if [ -z "$wallpaper" ]; then
    echo "No wallpapers found in $WALLPAPER_DIR"
    exit 1
fi

# Apply the wallpaper using swww
if swww img "$wallpaper"; then
    echo "Applied wallpaper: $wallpaper"
else
    echo "Error applying wallpaper"
    exit 1
fi

# Generate and apply colors using pywal
if wal -i "$wallpaper"; then
    echo "Updated colors with pywal"
else
    echo "Error updating colors with pywal"
    exit 1
fi

# Reload Waybar to apply new colors
if pkill -SIGUSR2 waybar; then
    echo "Reloaded Waybar"
else
    echo "Error reloading Waybar"
    exit 1
fi
