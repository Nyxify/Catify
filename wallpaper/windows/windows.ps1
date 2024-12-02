# Define the directory where wallpapers will be stored
$WALLPAPER_DIR = "$env:USERPROFILE\catify\wallpapers"
# Define the GitHub URL for the Catify repository
$GITHUB_URL = "https://github.com/Nyxify/Catify.git"

# Check if the wallpaper directory exists. If it does, clone the repository in a separate process.
# If it doesn't exist, create the directory and clone the repository in the current process.
if (Test-Path -Path $WALLPAPER_DIR) {
    Start-Process -FilePath "powershell" -ArgumentList "-Command", "git clone $GITHUB_URL `"$WALLPAPER_DIR\temp`"; Move-Item `"$WALLPAPER_DIR\temp\wallpaper\assets\*`" $WALLPAPER_DIR -Force; Remove-Item `"$WALLPAPER_DIR\temp`" -Recurse -Force" -WindowStyle Hidden
} else {
    New-Item -ItemType Directory -Force -Path $WALLPAPER_DIR | Out-Null
    Start-Process -FilePath "powershell" -ArgumentList "-Command", "git clone $GITHUB_URL `"$WALLPAPER_DIR\temp`"; Move-Item `"$WALLPAPER_DIR\temp\wallpaper\assets\*`" $WALLPAPER_DIR -Force; Remove-Item `"$WALLPAPER_DIR\temp`" -Recurse -Force" -WindowStyle Hidden -Wait
}

# Select a random wallpaper from the directory
$WALLPAPER = Get-ChildItem -Path $WALLPAPER_DIR -Include @("*.jpg","*.jpeg","*.png") -Recurse | Get-Random | Select-Object -ExpandProperty FullName

# Add a .NET type definition for interacting with the Windows API to set the wallpaper
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class Wallpaper {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@

# Set the wallpaper using the Windows API
$SPI_SETDESKWALLPAPER = 0x0014
$SPIF_UPDATEINIFILE = 0x01
$SPIF_SENDCHANGE = 0x02

[Wallpaper]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $WALLPAPER, $SPIF_UPDATEINIFILE -bor $SPIF_SENDCHANGE) 