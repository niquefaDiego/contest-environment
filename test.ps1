.\_\PS\initializeVariables.ps1

if ( !$task ) {
	.\_\PS\taskNotInitalized.ps1
	Exit
}

$checker="_\bin\checkers\tokens.exe"
$exe="$task\main.exe"
$casesFolder="$task\cases"

if ( !(Test-Path $exe) ) {
	.\_\PS\exeNotFound.ps1
	Exit
}

if ( $args.Count -ne 0 ) {
	$inputFiles = @()
	foreach ( $a in $args ) {
		$inputFiles += "$casesFolder\$a.in"
	}
}
else {
	$inputFiles = Get-ChildItem -Path "$casesFolder\*.in"
}

Write-Output "Testing Task $task"
foreach ( $inFile in $inputFiles ) {
	$noExt = "$casesFolder\$((Get-Item $inFile).BaseName)"
	$testId = (Get-Item $inFile).BaseName
	$outFile = "$noExt.txt"
	$ansFile = "$noExt.out"
	Get-Content $inFile | &$exe | Out-File -FilePath $outFile -Encoding ASCII
	&./$checker $testId $inFile $ansFile $outFile
}