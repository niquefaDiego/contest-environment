function Initialize-Dir
{
  Param($Dir)
  Remove-Item -Recurse -Force $Dir
  New-Item -ItemType directory -Path $Dir
  New-Item -ItemType directory -Path "$Dir\cases"
  Copy-Item "_\data\template.cpp" "$Dir\main.cpp"
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