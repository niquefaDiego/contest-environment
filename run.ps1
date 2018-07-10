param (
  [switch] $NoIn,  # Do not show input
  [switch] $NoOut  # Do not show answer
)

.\_\src\ps\initializeVariables.ps1

if ( !$task ) {
	& ".\$src\ps\taskNotInitalized.ps1"
	Exit
}

$dir=Join-Path -Path $workspace -ChildPath $task
$cases=Join-Path -Path $dir -ChildPath "\cases"
$source=Join-Path -Path $dir -ChildPath $sol
$runPS=".\$src\ps\run\run.ps1"

if ( !(Test-Path $source) ) {
	Write-Output "$source not found"
	Exit
}

if ( $args.Count -eq 0 ) {
  Write-Output "Running Task $task with stdin/stdout"
  & $runPS $source
}
else
{
	$inFile = "$cases\$($args[0]).in"
	$ansFile = "$cases\$($args[0]).out"
	if ( !(Test-Path $inFile ) ) {
		Write-Output "$inFile not found"
		Exit
	}

	Write-Output "Running solution $source"
  if ( -not $NoIn ) {
    Write-Output "-------------------- INPUT ---------------------"
    Get-Content $inFile
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
	& $runPS $source $inFile
}
