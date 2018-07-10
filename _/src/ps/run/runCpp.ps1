$source=$args[0]
$exe=Join-Path -Path $dir -ChildPath "$((Get-Item $source).BaseName).exe"

if ( !(Test-Path $exe) ) {
	.\_\PS\exeNotFound.ps1
  Exit
}

if ( $args.Count -eq 1 ) {
	& $exe
}
elseif ( $args.Count -eq 2 ) {
	Get-Content $args[1] | &$exe
}
else {
	Get-Content $args[1] | &$exe | Out-File -FilePath $args[2] -Encoding ASCII
}
