function RandomString([Int]$Size = 8, [Char[]]$CharSets = "ULNS", [Char[]]$Exclude) {
	$Chars = @();
	$TokenSet = @();
    If (!$TokenSets) {
		$Global:TokenSets = @{
        	U = [Char[]]'ABCDEFGHIJKLMNOPQRSTUVWXYZ'                                #Upper case
        	L = [Char[]]'abcdefghijklmnopqrstuvwxyz'                                #Lower case
        	N = [Char[]]'0123456789'                                                #Numerals
        	S = [Char[]]'-'                         #Symbols
		}
	}
    $CharSets | ForEach-Object { 
		#this part basically rearrange the whole sets, during which a mandatory upper case is fixed
        $Tokens =		$TokenSets."$_" | ForEach-Object {If ($Exclude -cNotContains $_) {$_}}; #remove excluded characters and save rest in Tokens
		If ($Tokens) 
		{
            $TokensSet += $Tokens
			If ($_ -cle [Char]"Z") 
			{
				$Chars += $Tokens | Get-Random
			}             #Character sets defined in upper case are mandatory
        }
    }
	While ($Chars.Count -lt $Size) {$Chars += $TokensSet | Get-Random};
	#Write-Output $Chars;
    ($Chars | Sort-Object {Get-Random}) -Join ""                                #Mix the (mandatory) characters and output string
}

function rs([Int]$Size = 20){
	$tempstring = RandomString $size;
	Set-Clipboard $tempstring;
	Write-Output $tempstring;

}


function guid{
	$tempGUID = New-Guid;
	Write-Output $tempGUID;
	Set-Clipboard $tempGUID;
}

