#!/bin/bash

# Function to enable/disable automatic wallpaper switching on startup
toggle_autostart() {
    # Define paths
    AUTOSTART_FILE="$HOME/.config/autostart/catify-wallpaper.desktop"
    CATIFY_DIRECTORY="$HOME/.local/share/catify"

    # Check if autostart is currently enabled
    if [ -f "$AUTOSTART_FILE" ]; then
        # If enabled, disable it by removing the file
        rm "$AUTOSTART_FILE"
        echo "Automatic wallpaper switching disabled"
    else
        # If disabled, enable it by creating the autostart file
        cat > "$AUTOSTART_FILE" << EOL
[Desktop Entry]
Type=Application
Name=Catify Wallpaper
Exec=$CATIFY_DIRECTORY/wallpaper.sh
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
EOL
        echo "Automatic wallpaper switching enabled"
    fi
}

# Show usage instructions if no arguments provided
if [ $# -eq 0 ]; then
    echo "Usage:"
    echo "  catify update          - Update Catify"
    echo "  catify toggle          - Toggle automatic wallpaper switching"
    echo "  catify uninstall       - Uninstall Catify"
    exit 1
fi

# Process the command line arguments
case "$1" in
    "update")
        bash "$(dirname "$0")/update.sh"
        ;;
    "toggle")
        toggle_autostart
        ;;
    "uninstall")
        bash "$(dirname "$0")/uninstall.sh"
        ;;
    "switch")
        bash "$(dirname "$0")/wallpaper.sh"
        ;;
    "help")
        echo "Usage:"
        echo "  catify update          - Update Catify"
        echo "  catify toggle          - Toggle automatic wallpaper switching"
        echo "  catify uninstall       - Uninstall Catify"
        echo "  catify switch          - Switch wallpaper now"
        echo "  catify help            - Show this help message"
        ;;
    *)
        echo "Unknown command: $1"
        echo "Available commands: update, toggle, uninstall, switch, help"
        exit 1
        ;;
esac
