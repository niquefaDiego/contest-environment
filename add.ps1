
.\_\src\ps\initializeVariables.ps1

$dir=$workspace+$task
if ( !$dir ) {
	.\$src\ps\taskNotInitalized.ps1
	Exit
}

& ".\$bin\cpp\add_cases.exe" "$dir\cases"