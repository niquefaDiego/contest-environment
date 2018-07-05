
.\_\src\ps\firstTimeConfig\buildCppFiles.ps1

$defaultTask = Read-Host "Default task folder"
$defaultTask = $defaultTask -Replace "\\","\\"

$settingsContent = 
@"
defaultTask=$defaultTask
defaultUser=default
"@
Write-Output $settingsContent | Out-File -FilePath "_\settings.txt"
