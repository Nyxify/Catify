# Define paths for the script and its autostart location
$SCRIPT_DIR = "$env:USERPROFILE\catify"
$SCRIPT_PATH = "$SCRIPT_DIR\windows.ps1"
$STARTUP_DIR = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"

# Ensure the script directory exists, creating it if necessary
New-Item -ItemType Directory -Force -Path $SCRIPT_DIR | Out-Null

# Download the script from GitHub
$SCRIPT_URL = "https://raw.githubusercontent.com/Nyxify/Catify/refs/heads/main/wallpaper/windows/windows.ps1"
Invoke-WebRequest -Uri $SCRIPT_URL -OutFile $SCRIPT_PATH

# Create a shortcut in the startup directory to run the script on startup
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut("$STARTUP_DIR\CatifyWallpaper.lnk")
$Shortcut.TargetPath = "powershell.exe"
$Shortcut.Arguments = "-WindowStyle Hidden -ExecutionPolicy Bypass -NoLogo -NonInteractive -File `"$SCRIPT_PATH`""
$Shortcut.WindowStyle = 7  # Set the window style to minimized
$Shortcut.Save()

# Execute the script for the first time to apply the wallpaper
& $SCRIPT_PATH

Write-Host "Installation complete! Wallpaper script will run on startup."