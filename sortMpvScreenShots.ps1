param([int]$n=0)
Get-ChildItem *.png,*.jpeg,*.jpg,*.webp | ForEach-Object{
    $mediaPrefix = $_.BaseName.Split('.')[0..($n - 1)] -join '.';
    write-output $mediaPrefix
    if((Test-Path -Path $mediaPrefix) -eq $false){
        mkdir $mediaPrefix;
    }
    Move-Item $_.FullName $mediaPrefix
}