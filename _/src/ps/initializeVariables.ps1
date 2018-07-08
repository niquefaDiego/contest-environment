
if ( !$global:task -or !$global:user) {
	if ( Test-Path -Path "_\settings.txt" )
	{
		$settings = Get-Content "_\settings.txt" | ConvertFrom-StringData
		if ( !$global:task -and $settings.defaultTask ) {
			$global:task = $settings.defaultTask
			Write-Output "task was set to default: $global:task"
		}
		if ( !$global:user -and $settings.defaultUser ) {
			$global:user = $settings.defaultUser
			Write-Output "user was set to default: $global:user"
		}
	}
}

$global:src="_\src"
$global:bin="_\bin"
$global:workspace="_workspace\"