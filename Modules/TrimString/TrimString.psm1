function TrimS{
	$StringToBeProcess = Get-Clipboard
    $StringToBeProcess = $StringToBeProcess.Replace(" ","").Replace("`n","") -join ""
    Set-Clipboard $StringToBeProcess
}

