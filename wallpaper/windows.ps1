# Add Windows Forms assembly for wallpaper setting
Add-Type -TypeDefinition @"
using System.Runtime.InteropServices;
public class Wallpaper {
    [DllImport("user32.dll", CharSet=CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@

# Define wallpaper directory
$WALLPAPER_DIR = "$env:USERPROFILE\.local\share\catify\wallpapers"
$GITHUB_URL = "https://github.com/Nyxify/Catify/wallpaper/assets"

# Create directory if it doesn't exist
if (-not (Test-Path $WALLPAPER_DIR)) {
    New-Item -ItemType Directory -Path $WALLPAPER_DIR -Force
}

# Clone/update wallpapers if needed
if (-not (Test-Path "$WALLPAPER_DIR\*")) {
    git clone $GITHUB_URL "$WALLPAPER_DIR\temp"
    Move-Item "$WALLPAPER_DIR\temp\*" $WALLPAPER_DIR -Force
    Remove-Item "$WALLPAPER_DIR\temp" -Recurse -Force
}

# Get random wallpaper
$WALLPAPER = Get-ChildItem -Path $WALLPAPER_DIR -Include *.jpg,*.jpeg,*.png -Recurse | Get-Random | Select-Object -ExpandProperty FullName

# Set wallpaper
$SPI_SETDESKWALLPAPER = 0x0014
$SPIF_UPDATEINIFILE = 0x01
$SPIF_SENDCHANGE = 0x02
[Wallpaper]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $WALLPAPER, $SPIF_UPDATEINIFILE -bor $SPIF_SENDCHANGE) 