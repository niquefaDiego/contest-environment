.\_\src\ps\initializeVariables.ps1

if ( !$task ) {
	& ".\$src\ps\taskNotInitalized.ps1"
	Exit
}

$checker="$bin\cpp\checkers\tokens.exe"
$dir=Join-Path -Path $workspace -ChildPath $task
$cases=Join-Path -Path $dir -ChildPath "\cases"
$source=Join-Path -Path $dir -ChildPath $sol

if ( !(Test-Path $source) ) {
	Write-Output "$source not found"
	Exit
}

if ( $args.Count -ne 0 ) {
	$inputFiles = @()
	foreach ( $a in $args ) {
		$inputFiles += "$cases\$a.in"
	}
}
else {
	$inputFiles = Get-ChildItem -Path "$cases\*.in"
}

Write-Output "Testing Task $task with solution $sol"
foreach ( $inFile in $inputFiles ) {
	$noExt = "$cases\$((Get-Item $inFile).BaseName)"
	$testId = (Get-Item $inFile).BaseName
	$outFile = "$noExt.txt"
	$ansFile = "$noExt.out"
	& ".\$src\ps\run\run.ps1" $source $inFile $outFile
	& .\$checker $testId $inFile $ansFile $outFile
}