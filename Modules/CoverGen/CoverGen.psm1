function Covergen($FilePath){
	$imwidth=magick identify -ping -format "%w" "$($FilePath)"
	$imwidth=[int]$imwidth;
	$imheight=magick identify -ping -format "%h" "$($FilePath)";
	$imheight=[int]$imheight;
	If($imheight -ge $imwidth)
	{
		magick "$($FilePath)" -gravity center -extent "($imheight)x($imheight)" "$($FilePath)";

	}
	Else
	{
		magick "$($FilePath)" -gravity center -extent "($imwidth)x($imwidth)" "$($FilePath)";
	}
}
