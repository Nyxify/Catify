$removed = $false

# Remove script directory
if (Test-Path "$env:USERPROFILE\.local\share\catify") {
    Remove-Item "$env:USERPROFILE\.local\share\catify" -Recurse -Force
    $removed = $true
}

# Remove startup shortcut
if (Test-Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\CatifyWallpaper.lnk") {
    Remove-Item "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\CatifyWallpaper.lnk" -Force
    $removed = $true
}

if ($removed) {
    Write-Host "Successfully uninstalled Catify Wallpapers."
} else {
    Write-Host "It doesn't seem like Catify Wallpapers was installed."
} 