# Set up paths for script and autostart
$SCRIPT_DIR = "$env:USERPROFILE\.local\share\catify"
$SCRIPT_PATH = "$SCRIPT_DIR\windows.ps1"
$STARTUP_DIR = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"

# Create script directory if it doesn't exist
New-Item -ItemType Directory -Force -Path $SCRIPT_DIR | Out-Null

# Download script from GitHub
$SCRIPT_URL = "https://raw.githubusercontent.com/Nyxify/Catify/refs/heads/main/wallpaper/windows/windows.ps1"
Invoke-WebRequest -Uri $SCRIPT_URL -OutFile $SCRIPT_PATH

# Create startup shortcut
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut("$STARTUP_DIR\CatifyWallpaper.lnk")
$Shortcut.TargetPath = "powershell.exe"
$Shortcut.Arguments = "-WindowStyle Hidden -ExecutionPolicy Bypass -NoLogo -NonInteractive -File `"$SCRIPT_PATH`""
$Shortcut.WindowStyle = 7  # Minimized window
$Shortcut.Save()

# Initial run
& $SCRIPT_PATH

Write-Host "Installation complete! Wallpaper script will run on startup."
