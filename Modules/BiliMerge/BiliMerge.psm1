function BMerge(){
    Get-ChildItem *.txt | ForEach-Object{ffmpeg -safe 0 -f concat -i "$($_.FullName)" -c copy "$($_.BaseName).mp4"}
}
