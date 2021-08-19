function Get-PSReadlineHistory{
    Write-Output "Get-Content (Get-PSReadlineOption).HistorySavePath";
    Get-Content (Get-PSReadlineOption).HistorySavePath;
}
