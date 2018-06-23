
Write-Output "Compiling _\src\add_cases.cpp"
g++ -std=c++0x _\src\add_cases.cpp -o _\bin\add_cases.exe
Write-Output "Compiling _\src\precompiler\precompiler.cpp"
g++ -std=c++0x _\src\precompiler\precompiler.cpp -o _\bin\precompiler\precompiler.exe
Write-Output "Compiling _\src\checkers\tokens.cpp"
g++ -std=c++0x _\src\checkers\tokens.cpp -o _\bin\checkers\tokens.exe

$defaultTask = Read-Host "Default task folder"

Write-Output "defaultTask=$defaultTask" | Out-File -FilePath "_\config.txt"
Add-Content -Path "_\config.txt" -Value "defaultUser=default"