$text = get-content .\post.txt;
$pattern = '(\$.+?\$)';
$text |ForEach-Object{
    if([regex]::Matches($_, $pattern).Value){
        $original_text = $_;
        # $trimedFunction= ([regex]::Matches($_, $pattern).Value).replace('$','');
        foreach($match in [regex]::Matches($_, $pattern).Value){
            $trimedMatch= ([regex]::Matches($match, $pattern).Value).replace('$','');
            # Write-Output "trimedMatch",$trimedMatch
            $url = Eq-Render $trimedMatch;
            # Write-Output "url",$url
            $original_text =$original_text.replace($match,"[img]$($url)[/img]")
            # Write-Output "original_text",$original_text
        }
        Write-Output $original_text;
        }else {
        Write-Output $_
    }
}