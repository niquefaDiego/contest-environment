
.\_\src\ps\initializeVariables.ps1

if ( !$task ) {
	.\$src\ps\taskNotInitalized.ps1
	Exit
}

Copy-Item "$task\$($args[0]).cpp" "$task\main.cpp"
