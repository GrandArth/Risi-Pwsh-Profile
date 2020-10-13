function enb64($Text){
	$Bytes = [System.Text.Encoding]::UTF8.GetBytes($Text);
	$EncodedText =[Convert]::ToBase64String($Bytes);
	Set-Clipboard $EncodedText;
	Write-Output $EncodedText;
}

function deb64($EncodedText){
	$DecodedText = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($EncodedText))
	Set-Clipboard $DecodedText;
	Write-Output $DecodedText;
}
