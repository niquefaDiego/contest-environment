Write-Output "Task $($task)"

$folder=$task
$source=$folder+"\main.cpp"
$exe=$folder+"\main.exe"

Write-Output "Running precompiler..."
$precompiler="_\precompiler.exe"
$tmp1="_\tmp\1.cpp"
Copy-Item $source $tmp1
Get-Content $tmp1 | & $precompiler | Out-File -FilePath $source -Encoding ASCII

if ( Test-Path $exe ) {
    Remove-Item $exe
}


Write-Output "Compiling"
g++ -std=c++0x -Wall -Wno-sign-compare $source -o $exe

if ( !(Test-Path $exe) ) {
    Write-Warning "COMPILATION ERROR"
}
