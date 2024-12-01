#!/bin/bash

removed=false

if [ -f ~/.local/share/catify ]; then
  rm -rf ~/.local/share/catify
  removed=true
fi

if [ -f ~/.config/autostart/catify-wallpaper.desktop ]; then
  rm -rf ~/.config/autostart/catify-wallpaper.desktop
  removed=true
fi

if [ "$removed" = true ]; then
  echo "Successfully uninstalled Catify Wallpapers."
else
  echo "It doesn't seem like Catify Wallpapers was installed."
fi