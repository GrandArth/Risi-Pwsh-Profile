function FileBRE{
	param (
		[Parameter(Position=0)][string]$OriginEncoding="GB2312",
		[Parameter(Position=1,Mandatory=$true)][string]$FileExtension,
		[Parameter(Position=2,Mandatory=$true)][string]$TargetEncoding="utf-8"
	)
	$OriginEncoder = [System.Text.Encoding]::GetEncoding($OriginEncoding);
	$TargetEncoder = [System.Text.Encoding]::GetEncoding($TargetEncoding);
	Write-Output $OriginEncoder;
	Write-Output $TargetEncoder;
	Get-ChildItem  "*.$($FileExtension)" | ForEach-Object {
		$FileContent = Get-Content -LiteralPath $_.FullName -Raw -Encoding $OriginEncoder.CodePage;
		if($FileContent){
			if($TargetEncoding -eq "utf-8"){
				Set-Content -LiteralPath "$($_.Directory)/$($_.BaseName)-$($TargetEncoding).$($FileExtension)" -Value $FileContent -Encoding "utf8NoBOM";
			}else {
				Set-Content -LiteralPath "$($_.Directory)/$($_.BaseName)-$($TargetEncoding).$($FileExtension)" -Value $FileContent -Encoding $TargetEncoder.CodePage;
			}
		}
		Write-Output "$($_.Directory)/$($_.BaseName)-$($TargetEncoding).$($FileExtension)";
	} 
}
