function FileRE{
	param (
		[Parameter(Position=0)][string]$OriginEncoding="GB2312",
		[Parameter(Position=1,Mandatory=$true)][string]$FileExtension
	)
	$OriginEncoder = [System.Text.Encoding]::GetEncoding($OriginEncoding);
	$UTF8Encoder = [System.Text.Encoding]::GetEncoding("utf-8");
	Write-Output $OriginEncoder;
	Write-Output $UTF8Encoder;
	Get-ChildItem  "*.$($FileExtension)" | ForEach-Object {
		#$FileContent = Get-Content -LiteralPath "$($_.BaseName).cue" -Raw -AsByteStream;
		$FileContent = Get-Content -LiteralPath $_.FullName -Raw -AsByteStream;
		$FileContentConverted = [System.Text.Encoding]::Convert($OriginEncoder, $UTF8Encoder, $FileContent);
		$FileString = $UTF8Encoder.GetString($FileContentConverted);
		Set-Content -LiteralPath "$($_.Directory)/$($_.BaseName).$($FileExtension)" -Value $FileString;
		Write-Output "$($_.Directory)/$($_.BaseName).$($FileExtension)";
	} 
}
