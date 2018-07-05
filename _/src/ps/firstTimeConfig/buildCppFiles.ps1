
$srcDir="_\src\cpp"
$binDir="_\bin\cpp"

New-Item -Force -ItemType Directory -Path "_\bin" | Out-Null
New-Item -Force -ItemType Directory -Path "$binDir" | Out-Null
New-Item -Force -ItemType Directory -Path "$binDir\checkers" | Out-Null
New-Item -Force -ItemType Directory -Path "$binDir\precompiler" | Out-Null

Write-Output "Compiling $srcDir\add_cases.cpp"
g++ -std=c++0x "$srcDir\add_cases.cpp" -o "$binDir\add_cases.exe"

Write-Output "Compiling $srcDir\checkers\tokens.cpp"
g++ -std=c++0x "$srcDir\checkers\tokens.cpp" -o "$binDir\checkers\tokens.exe"

Write-Output "Compiling $srcDir\precompiler\precompiler.cpp"
g++ -std=c++0x "$srcDir\precompiler\precompiler.cpp" -o "$binDir\precompiler\precompiler.exe"