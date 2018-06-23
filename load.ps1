
.\_\PS\initializeVariables.ps1

if ( !$task ) {
	.\_\PS\taskNotInitalized.ps1
	Exit
}

Copy-Item "$task\$($args[0]).cpp" "$task\main.cpp"
