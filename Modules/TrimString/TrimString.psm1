function TrimS{
	param(
		[parameter(Position=0)][string]$StringToBeProcess=""		
	)
    Set-Clipboard $StringToBeProcess.Replace(" ","").Replace("`n","")
}

