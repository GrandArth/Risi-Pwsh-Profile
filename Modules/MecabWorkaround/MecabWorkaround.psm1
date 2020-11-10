function mmecab{
	param (
		[string]$InputString
	)
	<#
	Set-Content -LiteralPath "$($PWD)/temp.txt" -Value $InputString;
	mecab "$($PWD)/temp.txt" -o "$($PWD)/temp-output.txt";
	Get-Content -LiteralPath "$($PWD)/temp-output.txt";
	Remove-Item -LiteralPath "$($PWD)/temp.txt";
	Remove-Item -LiteralPath "$($PWD)/temp-output.txt";
	#>
	Write-Output $InputString | mecab -d "C:\Program Files\MeCab\dic\mecab-ipadic-neologd";
}