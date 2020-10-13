
function gtype{
	param(
		[string]$TargetDirectory = $PWD.ToString()
	)
	Get-Childitem -Recurse -File -LiteralPath $TargetDirectory | Select-Object Extension -Unique
	}

function mdel{
	param(
		[Parameter(Mandatory=$true,Position=0)][string]$TargetFileFormat,
		[string]$TargetDirectory = $PWD.ToString()
	)
	Get-ChildItem -recurse -LiteralPath $TargetDirectory -include *.$TargetFileFormat |ForEach-Object{
		$_.Delete();
	}
}
