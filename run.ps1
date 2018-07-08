param (
  [switch] $NoIn,  # Do not show input
  [switch] $NoOut  # Do not show answer
)

.\_\src\ps\initializeVariables.ps1

if ( !$task ) {
	.\$src\ps\taskNotInitalized.ps1
	Exit
}

$cases=$workspace+$task+"\cases"
$exe=$workspace+$task+"\main.exe"

if ( !(Test-Path $exe) ) {
	.\_\PS\exeNotFound.ps1
  Exit
}

if ( $args.Count -eq 0 ) {
  Write-Output "Running Task $task with stdin/stdout"
  & $exe
}
else
{
	$inFile = "$cases\$($args[0]).in"
	$ansFile = "$cases\$($args[0]).out"
	if ( !(Test-Path $inFile ) ) {
		Write-Output "$inFile not found"
		Exit
	}

  if ( -not $NoIn ) {
    Write-Output "-------------------- INPUT ---------------------"
    Get-Content $inFIle
  }
  if ( -not $NoOut ) {
		Write-Output "-------------------- ANSWER --------------------"
		if ( Test-Path $ansFile  ) {
    	Get-Content $ansFile
		}
		else {
			Write-Output "$ansFile not found"
		}
  }
	Write-Output "-------------------- OUTPUT --------------------"
	Get-Content "$cases\$($args[0]).in" | & $exe
}
