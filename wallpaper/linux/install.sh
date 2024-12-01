#!/bin/bash

# Set up paths for script and autostart
SCRIPT_DIR="$HOME/.local/share/catify"
SCRIPT_PATH="$SCRIPT_DIR/linux.sh"
AUTOSTART_DIR="$HOME/.config/autostart"
AUTOSTART_FILE="$AUTOSTART_DIR/catify-wallpaper.desktop"

# Set up directories
mkdir -p "$SCRIPT_DIR"
mkdir -p "$AUTOSTART_DIR"

# Get script from GitHub
curl -s "https://raw.githubusercontent.com/Nyxify/Catify/refs/heads/main/wallpaper/linux/linux.sh" -o "$SCRIPT_PATH"
chmod +x "$SCRIPT_PATH"

# Configure autostart
cat > "$AUTOSTART_FILE" << EOL
[Desktop Entry]
Type=Application
Name=Catify Wallpaper
Exec=$SCRIPT_PATH
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
EOL

# Initial run
"$SCRIPT_PATH"

echo "Installation complete! Wallpaper script will run on startup."
