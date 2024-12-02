$removed = $false

# Check and remove the script directory if it exists
if (Test-Path "$env:USERPROFILE\catify") {
    Remove-Item "$env:USERPROFILE\catify" -Recurse -Force
    $removed = $true
}

# Check and remove the startup shortcut if it exists
if (Test-Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\CatifyWallpaper.lnk") {
    Remove-Item "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\CatifyWallpaper.lnk" -Force
    $removed = $true
}

# Display uninstallation status
if ($removed) {
    Write-Host "Successfully uninstalled Catify Wallpapers."
} else {
    Write-Host "It doesn't seem like Catify Wallpapers was installed."
} 