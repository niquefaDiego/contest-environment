
.\_\PS\initializeVariables.ps1

if ( !$task ) {
	.\_\PS\taskNotInitalized.ps1
	Exit
}

$folder=$task
$source=$folder+"\main.cpp"
$exe=$folder+"\main.exe"

Write-Output "Task $($task)"

Write-Output "Running precompiler..."
$precompiler="_\bin\precompiler\precompiler.exe"
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
