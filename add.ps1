
.\_\src\ps\initializeVariables.ps1

if ( !$task ) {
	.\$src\ps\taskNotInitalized.ps1
	Exit
}

& ".\$bin\cpp\add_cases.exe" "$task\cases"