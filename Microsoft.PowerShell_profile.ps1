Get-Job | Remove-Job;
Write-Output @"
This Powershel 7.0 + profile is created by:
 ____  ____    _    __  __ 
|  _ \/ ___|  / \  |  \/  |
| |_) \___ \ / _ \ | |\/| |
|  _ < ___) / ___ \| |  | |
|_| \_\____/_/   \_\_|  |_|
Enjoy! And Don't Panic!
"@

Set-Alias -Name ro -Value RollDice;
Set-Alias -Name ss -Value Select-String;
Set-Alias -Name cr -Value Clear-RecycleBin;
Set-Alias -Name mc -Value mmecab;
Set-Alias -Name rom -Value RollDiceMultiple;
Set-Alias -Name st -Value Start-Tim;
Set-Alias -Name crc -Value Add-FileCRC;
Set-Alias -Name pwhis -Value Get-PSReadlineHistory;
Set-Alias -Name sconda -Value D:\User\anaconda\shell\condabin\conda-hook.ps1;

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8;
[Console]::InputEncoding = [System.Text.Encoding]::UTF8;

Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

$PSReadLineOptions = @{
    HistoryNoDuplicates = $true
    HistorySearchCursorMovesToEnd = $true
}
Set-PSReadLineOption @PSReadLineOptions
