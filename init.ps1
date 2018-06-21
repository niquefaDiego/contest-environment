function Initialize-Dir
{
	Param($Dir)
	if ( Test-Path $Dir ) {
		Remove-Item -Recurse -Force $Dir
	}
  New-Item -ItemType directory -Path $Dir | Out-Null
  New-Item -ItemType directory -Path "$Dir\cases" | Out-Null
	Copy-Item "_\data\template.cpp" "$Dir\main.cpp"
	Write-Output "Initialized directory $Dir"
}

if ($args.Count -eq 0) {
	if ( !$task ) {
		Write-Output "You need to set task or pass folders as arguments"
		Write-Output "https://github.com/niquefaDiego/contest-environment/wiki/PowerShell-scripts-usage#initialize-the-solution-folder"
		Exit
	}
  Initialize-Dir -Dir $task
}
else
{
  foreach ($a in $args) {
    Initialize-Dir -Dir $a
  }
}