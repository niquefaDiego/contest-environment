if ( $args.Count -eq 1 ) {
	Write-Output "-------------------- INPUT ---------------------"
	Get-Content "$task\cases\$($args[0]).in"
	Write-Output "-------------------- ANSWER --------------------"
	Get-Content "$task\cases\$($args[0]).out"
	Write-Output "-------------------- OUTPUT --------------------"
	Get-Content "$task\cases\$($args[0]).txt"
}
else {
	Write-Warning "Need the test id as argument"
}

