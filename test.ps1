.\_\src\ps\initializeVariables.ps1

if ( !$task ) {
	.\$src\ps\taskNotInitalized.ps1
	Exit
}

$checker="$bin\cpp\checkers\tokens.exe"
$dir=$workspace+$task
$exe="$dir\main.exe"
$cases="$dir\cases"

if ( !(Test-Path $exe) ) {
	.\_\PS\exeNotFound.ps1
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

Write-Output "Testing Task $task"
foreach ( $inFile in $inputFiles ) {
	$noExt = "$cases\$((Get-Item $inFile).BaseName)"
	$testId = (Get-Item $inFile).BaseName
	$outFile = "$noExt.txt"
	$ansFile = "$noExt.out"
	Get-Content $inFile | &$exe | Out-File -FilePath $outFile -Encoding ASCII
	& .\$checker $testId $inFile $ansFile $outFile
}