Get-ChildItem *.png,*.jpeg,*.jpg,*.webp | ForEach-Object{
    $mediaPrefix = $_.BaseName.Split('-')[0];
    if((Test-Path -Path $mediaPrefix) -eq $false){
        mkdir $mediaPrefix;
    }
    Move-Item $_.FullName $mediaPrefix
}