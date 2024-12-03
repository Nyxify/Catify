#!/bin/bash

echo "Catify updater started..."

# Set up paths
CATIFY_DIRECTORY="$HOME/.local/share/catify"
GITHUB_URL="https://github.com/Nyxify/Catify.git"
AUTOSTART_DIRECTORY="$HOME/.config/autostart"
AUTOSTART_FILE="$AUTOSTART_DIRECTORY/catify-wallpaper.desktop"

# Check if autostart was previously enabled
AUTOSTART_ENABLED=false
if [ -f "$AUTOSTART_FILE" ]; then
    AUTOSTART_ENABLED=true
fi

# Create/update installation directory
mkdir -p "$CATIFY_DIRECTORY"
mkdir -p "$CATIFY_DIRECTORY/wallpapers"
mkdir -p "$AUTOSTART_DIRECTORY"

# Clone repository
git clone "$GITHUB_URL" "$CATIFY_DIRECTORY/temp"

# Move files to installation directory
mv -f "$CATIFY_DIRECTORY/temp/linux/catify.sh" "$CATIFY_DIRECTORY/"
mv -f "$CATIFY_DIRECTORY/temp/linux/uninstall.sh" "$CATIFY_DIRECTORY/"
mv -f "$CATIFY_DIRECTORY/temp/linux/update.sh" "$CATIFY_DIRECTORY/"
mv -f "$CATIFY_DIRECTORY/temp/linux/wallpaper.sh" "$CATIFY_DIRECTORY/wallpaper.sh"
mv -f "$CATIFY_DIRECTORY/temp/assets/"* "$CATIFY_DIRECTORY/wallpapers/"

# Update symlink
rm -f "/usr/local/bin/catify"
ln -s "$CATIFY_DIRECTORY/catify.sh" "/usr/local/bin/catify"

# Clean up temp directory
rm -rf "$CATIFY_DIRECTORY/temp"

# Make scripts executable
chmod +x "$CATIFY_DIRECTORY/catify.sh"
chmod +x "$CATIFY_DIRECTORY/uninstall.sh"
chmod +x "$CATIFY_DIRECTORY/update.sh"
chmod +x "$CATIFY_DIRECTORY/wallpaper.sh"

# Recreate autostart file if it was previously enabled
if [ "$AUTOSTART_ENABLED" = true ]; then
    cat > "$AUTOSTART_FILE" << EOL
[Desktop Entry]
Type=Application
Name=Catify Wallpaper
Exec=$CATIFY_DIRECTORY/wallpaper.sh
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
EOL
fi

echo "Update complete!"