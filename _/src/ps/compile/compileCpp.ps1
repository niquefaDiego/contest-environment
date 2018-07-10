$source=$args[0]
$exe=Join-Path -Path $dir -ChildPath "$((Get-Item $source).BaseName).exe"

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
