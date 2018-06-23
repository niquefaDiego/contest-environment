

New-Item -Force -ItemType Directory -Path "_\bin" | Out-Null
New-Item -Force -ItemType Directory -Path "_\bin\precompiler" | Out-Null
New-Item -Force -ItemType Directory -Path "_\bin\checkers" | Out-Null

Write-Output "Compiling _\src\add_cases.cpp"
g++ -std=c++0x _\src\add_cases.cpp -o _\bin\add_cases.exe
Write-Output "Compiling _\src\precompiler\precompiler.cpp"
g++ -std=c++0x _\src\precompiler\precompiler.cpp -o _\bin\precompiler\precompiler.exe
Write-Output "Compiling _\src\checkers\tokens.cpp"
g++ -std=c++0x _\src\checkers\tokens.cpp -o _\bin\checkers\tokens.exe

$defaultTask = Read-Host "Default task folder"
$defaultTask = $defaultTask -Replace "\\","\\"

$settingsContent = 
@"
defaultTask=$defaultTask
defaultUser=default
"@
Write-Output $settingsContent | Out-File -FilePath "_\settings.txt"
