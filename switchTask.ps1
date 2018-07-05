
.\_\src\ps\initializeVariables.ps1

if ( !$task ) {
	.\$src\ps\taskNotInitalized.ps1
	Exit
}

if ( $args.Count -eq 1 ) {
	$task=Split-Path $task
	$task=Join-Path -Path $task -ChildPath $args[0]
	$global:task=$task
	Write-Output "Now task=$task"
}
else {
	Write-Output "Expected exactly 1 argument: the folder to switch the last folder of $task with"
 }
