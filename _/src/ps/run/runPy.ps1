$source=$args[0]

if ( $args.Count -eq 1 ) {
	& python $source
}
elseif ( $args.Count -eq 2 ) {
	Get-Content $args[1] | & python $source
}
else {
	Get-Content $args[1] | & python $source | Out-File -FilePath $args[2] -Encoding ASCII
}