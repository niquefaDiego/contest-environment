$SEE_INIT_DOCUMENTATION = "see https://github.com/niquefaDiego/contest-environment/wiki/PowerShell-scripts-usage#initialize-the-solution-folder"

function Initialize-Dir
{
	Param($Dir)
	if ( Test-Path $Dir ) {
		Remove-Item -Recurse -Force $Dir
	}
  New-Item -ItemType Directory -Path $Dir | Out-Null
  New-Item -ItemType Directory -Path "$Dir\cases" | Out-Null
	Copy-Item "_\users\default\template.cpp" "$Dir\main.cpp"
	Write-Output "Initialized directory $Dir"
}

if ($args.Count -eq 0) {
	
	.\_\PS\initializeVariables.ps1

	if ( !$task ) {
		Write-Output "You need to set task or pass folders as arguments"
		Write-Output $SEE_INIT_DOCUMENTATION
		Exit
	}
  Initialize-Dir -Dir $task
}
elseif ( $args.Count -eq 1 )
{
	Initialize-Dir $args[0]
}
elseif ( $args.Count -eq 2 )
{
	if ( ! ($args[1] -is [int] ) -or ( $args[1] -le 0 ) ) {
		Write-Output "The second argument must be a positive integer"
		Write-Output $SEE_INIT_DOCUMENTATION
		Exit
	}
	for ($i=0; $i -lt $args[1]; $i++) {
		$problemId=[char]($i+[byte][char]'A')
    Initialize-Dir -Dir "$($args[0])\$problemId"
  }
}
else {
	Write-Output "This scripts takes 0, 1 or 2 arguments"
	Write-Output $SEE_INIT_DOCUMENTATION
}