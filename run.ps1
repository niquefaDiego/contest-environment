param (
  [switch] $NoIn,  # Do not show input
  [switch] $NoAns, # Do not show answer
  [switch] $NoOut  # Do not show output (doesn't run the solution)
)


$folder=$task+"\cases"
$exe=$task+"\main.exe"

if ( !(Test-Path $exe) ) {
  WRite-Output "$exe file was not found"
  Exit
}

if ( $args.Count -eq 0 ) {
  Write-Output "Running Task $task with stdin/stdout"
  & $exe
}
else
{
  if ( -not $NoIn ) {
    Write-Output "-------------------- INPUT ---------------------"
    Get-Content "$folder\$($args[0]).in"
  }
  if ( -not $NoAns ) {
    Write-Output "-------------------- ANSWER --------------------"
    Get-Content "$folder\$($args[0]).out"
  }
  if ( -not $NoOut ) {
    Write-Output "-------------------- OUTPUT --------------------"
    Get-Content "$folder\$($args[0]).in" | & $exe
  }
}
