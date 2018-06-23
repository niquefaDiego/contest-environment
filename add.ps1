
.\_\PS\initializeVariables.ps1

if ( !$task ) {
	.\_\PS\taskNotInitalized.ps1
	Exit
}

.\_\bin\add_cases.exe $task\cases