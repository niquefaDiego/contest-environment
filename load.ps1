
.\_\src\ps\initializeVariables.ps1

if ( !$task ) {
	.\$src\ps\taskNotInitalized.ps1
	Exit
}

$dir=$workspace+$task
Copy-Item "$dir\$($args[0]).cpp" "$dir\main.cpp"
