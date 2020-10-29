function CueBatch{
	param (
		[Parameter(Position=0)][string]$OriginEncoding="GB2312"
	)
	$OriginEncoder = [System.Text.Encoding]::GetEncoding($OriginEncoding);
	$UTF8Encoder = [System.Text.Encoding]::GetEncoding("utf-8");
	Write-Output $OriginEncoder;
	Write-Output $UTF8Encoder;
	Get-ChildItem *.cue | ForEach-Object {
		$FileContent = Get-Content $_.FullName -Raw -AsByteStream;
		$FileContentConverted = [System.Text.Encoding]::Convert($OriginEncoder, $UTF8Encoder, $FileContent);
		$FileString = $UTF8Encoder.GetString($FileContentConverted);
		Set-Content -Path "$($_.Directory)/$($_.BaseName)-utf8.cue" -Value $FileString;
	} 
}
