#!/bin/bash

# Download and set up wallpaper script
SCRIPT_DIR="$HOME/.local/share/catify"
SCRIPT_PATH="$SCRIPT_DIR/linux.sh"
AUTOSTART_DIR="$HOME/.config/autostart"
AUTOSTART_FILE="$AUTOSTART_DIR/catify-wallpaper.desktop"

# Create necessary directories
mkdir -p "$SCRIPT_DIR"
mkdir -p "$AUTOSTART_DIR"

# Download the script
curl -s "https://raw.githubusercontent.com/Nyxify/Catify/main/wallpaper/linux/linux.sh" -o "$SCRIPT_PATH"
chmod +x "$SCRIPT_PATH"

# Create autostart desktop entry
cat > "$AUTOSTART_FILE" << EOL
[Desktop Entry]
Type=Application
Name=Catify Wallpaper
Exec=$SCRIPT_PATH
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
EOL

# Run the script immediately
"$SCRIPT_PATH"

echo "Installation complete! Wallpaper script will run on startup."
