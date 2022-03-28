function AudioVideo-Merge(){
    $mp4Objects= ls *.mp4
    $m4aObjects = ls *.m4a
    ForEach($mp4Object in $mp4Objects){
        ForEach($m4aObject in $m4aObjects){
            if($mp4Object.BaseName -eq $m4aObject.BaseName){
                ffmpeg -i $mp4Object.FullName -i $m4aObject.FullName -c:v copy -c:a copy "$($mp4Object.BaseName).muxed.mp4"
            }
        }
    }
}
Set-Alias -Name av -Value AudioVideo-Merge;
