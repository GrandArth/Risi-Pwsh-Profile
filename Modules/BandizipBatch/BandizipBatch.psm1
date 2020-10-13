function BandizipAllSubFolder {
	param (
		[parameter(Position=0)][string]$RootPath = $PWD,
		[int]$CompressLevelALl=0,
		[int]$NumOfThreadsAll=10
	)
		Get-ChildItem -LiteralPath $RootPath -Directory | ForEach-Object{
			BandizipIt $_.FullName $_.FullName $CompressLevelALl $NumOfThreadsAll;
		}
}

function BandizipIt {
	param (
		[Parameter(Mandatory=$true,Position=0)][string]$TargetFolderPath,
		[Parameter(Mandatory=$true,Position=1)][string]$ResultArchievePath,
		[Parameter(Position=2)][int]$CompressLevel=0,
		[Parameter(Position=3)][int]$NumOfThreads=10
	)
	bz c -y -l:"$CompressLevel" -t:"$NumOfThreads" "$($ResultArchievePath).7z" "$TargetFolderPath" ;
}
