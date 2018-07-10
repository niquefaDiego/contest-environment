if ( ( $args.Count -eq 0 ) -or ( $args.Count -gt 3 ) ) {
	Write-Output "run.ps1 needs 1, 2 or 3 arguments"
}

$source=$args[0]

$ext=([IO.Path]::GetExtension($source)).ToLower()

$runPS=""
if ( $ext -eq ".cpp" ) { $runPs="Cpp" }
elseif ( $ext -eq ".py" ) { $runPs="Py" }
else {
	Write-Output "Can't run $ext files"
	Exit
}
$runPS=".\$src\ps\run\run$runPs.ps1"

if ( $args.Count -eq 1 ) {
	& $runPS $args[0]
}
elseif ( $args.Count -eq 2 ) {
	& $runPS $args[0] $args[1]
}
else {
	& $runPS $args[0] $args[1] $args[2]
}