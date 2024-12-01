#!/bin/bash

removed=false

if [ -d "$HOME/.local/share/catify" ]; then
  rm -rf "$HOME/.local/share/catify"
  removed=true
fi

if [ -f ~/.config/autostart/catify-wallpaper.desktop ]; then
  rm -rf $HOME/.config/autostart/catify-wallpaper.desktop
  removed=true
fi

if [ "$removed" = true ]; then
  echo "Successfully uninstalled Catify Wallpapers."
else
  echo "It doesn't seem like Catify Wallpapers was installed."
fi