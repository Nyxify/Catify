Set shell = CreateObject("Wscript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

' Define script paths
scriptPath = shell.ExpandEnvironmentStrings("%USERPROFILE%") & "\.local\share\catify\windows.ps1"
scriptDir = fso.GetParentFolderName(scriptPath)

' Create directory if it doesn't exist
If Not fso.FolderExists(scriptDir) Then
    fso.CreateFolder(scriptDir)
End If

' Download script only if it doesn't exist
If Not fso.FileExists(scriptPath) Then
    command = "powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -Command " & _
             """Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Nyxify/Catify/main/wallpaper/windows.ps1' " & _
             "-OutFile '" & scriptPath & "'"""
    shell.Run command, 0, True
End If

' Run the script
shell.Run "powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File """ & scriptPath & """", 0, False