$SEE_INIT_DOCUMENTATION = "see https://github.com/niquefaDiego/contest-environment/wiki/PowerShell-scripts-usage#initialize-the-solution-folder"

function Initialize-Dir
{
	Param($Dir)
	if ( Test-Path $Dir ) {
		Remove-Item -Recurse -Force $Dir
	}
  New-Item -ItemType Directory -Path $Dir | Out-Null
  New-Item -ItemType Directory -Path "$Dir\cases" | Out-Null
	Copy-Item "_\users\$user\template.cpp" "$Dir\main.cpp"
	Write-Output "Initialized directory $Dir"
}

.\_\src\ps\initializeVariables.ps1

if ($args.Count -eq 0) {
	$dir=$workspace+$task
	if ( !$dir ) {
		Write-Output "You need to set task or pass folders as arguments"
		Write-Output $SEE_INIT_DOCUMENTATION
		Exit
	}
  Initialize-Dir -Dir $dir
}
elseif ( $args.Count -eq 1 )
{
	Initialize-Dir "$workspace$args"
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
    Initialize-Dir -Dir "$workspace$($args[0])\$problemId"
  }
}
else {
	Write-Output "This scripts takes 0, 1 or 2 arguments"
	Write-Output $SEE_INIT_DOCUMENTATION
}