# Set up paths and URLs
$WALLPAPER_DIR = "$env:USERPROFILE\catify\wallpapers"
$GITHUB_URL = "https://github.com/Nyxify/Catify.git"

# Run in separate process if path exists, otherwise run directly
if (Test-Path -Path $WALLPAPER_DIR) {
    Start-Process -FilePath "powershell" -ArgumentList "-Command", "git clone $GITHUB_URL `"$WALLPAPER_DIR\temp`"; Move-Item `"$WALLPAPER_DIR\temp\wallpaper\assets\*`" $WALLPAPER_DIR -Force; Remove-Item `"$WALLPAPER_DIR\temp`" -Recurse -Force" -WindowStyle Hidden
} else {
    New-Item -ItemType Directory -Force -Path $WALLPAPER_DIR | Out-Null
    Start-Process -FilePath "powershell" -ArgumentList "-Command", "git clone $GITHUB_URL `"$WALLPAPER_DIR\temp`"; Move-Item `"$WALLPAPER_DIR\temp\wallpaper\assets\*`" $WALLPAPER_DIR -Force; Remove-Item `"$WALLPAPER_DIR\temp`" -Recurse -Force" -WindowStyle Hidden -Wait
}

# Select random wallpaper
$WALLPAPER = Get-ChildItem -Path $WALLPAPER_DIR -Include @("*.jpg","*.jpeg","*.png") -Recurse | Get-Random | Select-Object -ExpandProperty FullName

# Add Windows API call for setting wallpaper
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class Wallpaper {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@

# Set the wallpaper
$SPI_SETDESKWALLPAPER = 0x0014
$SPIF_UPDATEINIFILE = 0x01
$SPIF_SENDCHANGE = 0x02

[Wallpaper]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $WALLPAPER, $SPIF_UPDATEINIFILE -bor $SPIF_SENDCHANGE) 