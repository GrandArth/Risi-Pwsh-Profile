function Add-FileCRC{

    param(
        [Parameter(Position=0)][string]$FilePath,
        [Parameter(Position=1)][int]$RenameSwitch=0
    )

    #Write-Output "Add-FileCRC function need 7z.exe in your path!" ;
    $fileCRC = 7z  h -scrcCRC32 $FilePath | Select-String -Pattern "CRC32  for data" -NoEmphasis;
    $fileCRC=[string]$fileCRC;
    $fileCRC = $fileCRC.Split(" ")|Where-Object{$_ -ne ""};
    $fileCRC =$fileCRC[3];

    if($RenameSwitch){
        $File = Get-Item -LiteralPath $FilePath;
        Rename-Item -LiteralPath $FilePath -NewName "$($File.BaseName)[$($fileCRC)]$($File.Extension)"
    }

    return $fileCRC;
}

function Test-FileCRC{
    param(
        # Parameter help description
        [Parameter(Position=0)]
        [string]
        $FilePath
    )

    $File = Get-Item -LiteralPath $FilePath;
    $Regex = [regex] "\[([^\]]*)\][^\[]*$";
    $Match=$Regex.Match("$($File.BaseName)");
    if( "$(Add-FileCRC $FilePath)"  -ne  "$($Match.Groups[1].Value)"){
        Write-Output "Warning: $($File.FullName) failed CRC32 check!";
    }else {
        Write-Output "Pass!";
    }

}