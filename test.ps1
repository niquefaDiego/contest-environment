Write-Output "Testing Task $task"

$checker="_\checkers\tokens.exe"
$exe="$task\main.exe"
$casesFolder="$task\cases"

if ( !(Test-Path $exe) ) {
	Exit
}

$inputFiles = Get-ChildItem -Path "$casesFolder\*.in"

foreach ( $inFile in $inputFiles ) {
	$noExt = "$casesFolder\$((Get-Item $inFile).BaseName)"
	$testId = (Get-Item $inFile).BaseName
	$outFile = "$noExt.txt"
	$ansFile = "$noExt.out"
	Get-Content $inFile | &$exe | Out-File -FilePath $outFile -Encoding ASCII
	&./$checker $testId $inFile $ansFile $outFile
}