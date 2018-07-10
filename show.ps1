
.\_\src\ps\initializeVariables.ps1

if ( !$task ) {
	& ".\$src\ps\taskNotInitalized.ps1"
	Exit
}

$dir=$workspace+$task

if ( $args.Count -eq 1 ) {
	Write-Output "-------------------- INPUT ---------------------"
	Get-Content "$dir\cases\$($args[0]).in"
	Write-Output "-------------------- ANSWER --------------------"
	Get-Content "$dir\cases\$($args[0]).out"
	Write-Output "-------------------- OUTPUT --------------------"
	Get-Content "$dir\cases\$($args[0]).txt"
}
else {
	Write-Warning "Need the test id as argument"
}

