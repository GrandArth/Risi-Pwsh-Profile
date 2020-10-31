function Doloop{
	param (
		[Parameter(Position=0)][string]$CommandString="Write-output Nice_Try"
	)
	Do{ Invoke-Expression $CommandString}until($?);
}