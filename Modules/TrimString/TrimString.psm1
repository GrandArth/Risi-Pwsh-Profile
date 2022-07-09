function TrimS{
	$StringToBeProcess = Get-Clipboard
    Set-Clipboard $StringToBeProcess.Replace(" ","").Replace("`n","")
}

