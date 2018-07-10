
.\_\src\ps\initializeVariables.ps1

if ( !$task ) {
	& ".\$src\ps\taskNotInitalized.ps1"
	Exit
}

$dir=Join-Path -Path $workspace -ChildPath $task
$source=Join-Path -Path $dir -ChildPath $sol
$ext=([IO.Path]::GetExtension($source)).ToLower()

if ( !(Test-Path $source) ) {
	Write-Output "File $source doesn't exists"
	Exit
}

Write-Output "Task: $task"
Write-Output "Solution: $sol"

if ( $ext -eq ".cpp" ) {
	& ".\$src\ps\compile\compileCpp.ps1" $source
}
else {
	Write-Output "Can't compile files with $ext extension"
}