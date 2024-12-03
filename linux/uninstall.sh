#!/bin/bash

echo "Uninstalling Catify..."

# Define paths
CATIFY_DIRECTORY="$HOME/.local/share/catify"
AUTOSTART_FILE="$HOME/.config/autostart/catify-wallpaper.desktop"
SYMLINK="/usr/local/bin/catify"

# Remove autostart configuration if it exists
if [ -f "$AUTOSTART_FILE" ]; then
    rm "$AUTOSTART_FILE"
    echo "Removed autostart configuration"
fi

# Remove symlink
if [ -L "$SYMLINK" ]; then
    sudo rm "$SYMLINK"
    echo "Removed command symlink"
fi

# Remove Catify directory and all contents
if [ -d "$CATIFY_DIRECTORY" ]; then
    rm -rf "$CATIFY_DIRECTORY"
    echo "Removed Catify files"
fi

echo "Catify has been uninstalled successfully!"
