#!/bin/bash

# Set up paths and URLs
WALLPAPER_DIR="$HOME/.local/share/catify/wallpapers"
GITHUB_URL="https://github.com/Nyxify/Catify.git"

# Create directory and download wallpapers
mkdir -p "$WALLPAPER_DIR"
git clone "$GITHUB_URL" "$WALLPAPER_DIR/temp" && \
  mv "$WALLPAPER_DIR/temp/wallpaper/assets/"* "$WALLPAPER_DIR/" && \
  rm -rf "$WALLPAPER_DIR/temp"

# Select random wallpaper
WALLPAPER=$(find "$WALLPAPER_DIR" -type f -name "*.jp*g" -o -name "*.png" | shuf -n 1)

# Apply wallpaper based on desktop environment
case "$XDG_CURRENT_DESKTOP" in
  "KDE")   plasma-apply-wallpaperimage "$WALLPAPER" ;;
  "GNOME") gsettings set org.gnome.desktop.background picture-uri{,-dark} "file://$WALLPAPER" ;;
  "XFCE")  xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/workspace0/last-image -s "$WALLPAPER" ;;
  *)       command -v feh >/dev/null 2>&1 && feh --bg-fill "$WALLPAPER" || { echo "Unsupported desktop: $XDG_CURRENT_DESKTOP"; exit 1; } ;;
esac