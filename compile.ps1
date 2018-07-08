
.\_\src\ps\initializeVariables.ps1

if ( !$task ) {
	.\$src\ps\taskNotInitalized.ps1
	Exit
}

$dir=$workspace+$task
$source=$dir+"\main.cpp"
$exe=$dir+"\main.exe"

Write-Output "Task $($task)"

Write-Output "Running precompiler..."
$precompiler="_\bin\cpp\precompiler\precompiler.exe"
$tmp1="_\tmp\1.cpp"
Copy-Item $source $tmp1
Get-Content $tmp1 | & $precompiler $user | Out-File -FilePath $source -Encoding ASCII

if ( Test-Path $exe ) {
  Remove-Item $exe
}

Write-Output "Compiling"
g++ -std=c++0x -Wall -Wno-sign-compare $source -o $exe

if ( !(Test-Path $exe) ) {
	Write-Warning "COMPILATION ERROR"
}
