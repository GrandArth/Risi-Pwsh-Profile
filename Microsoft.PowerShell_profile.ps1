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


Set-Alias -Name ss -Value Select-String
Set-Alias -Name cr -Value Clear-RecycleBin


[Console]::OutputEncoding = [System.Text.Encoding]::UTF8;
[Console]::InputEncoding = [System.Text.Encoding]::UTF8;


$afy="--external-downloader aria2c --external-downloader-args `" -x 4 `"  --proxy `" http://127.0.0.1:9122 `" ".Split(' ');
$afb="--external-downloader aria2c --external-downloader-args `" -x 4 `" ".Split(' ');