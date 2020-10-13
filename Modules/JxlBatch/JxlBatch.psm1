function JXLmen{
	param(
		[parameter(Position=2)][string]$RootPath=$pwd,
		[parameter(Position=1)][int]$EncodeQuality=85,
		[parameter(Position=0)][int]$EncodeSpeed=3
		
	)
	Get-ChildItem -LiteralPath $RootPath *.* -Recurse | ForEach-Object{
		if($_.Extension -eq ".jpg"){
			cjpegxl $_.FullName "$($_.Directory)/$($_.BaseName)-jxl.jxlg" -s $EncodeSpeed;
			#use default transcode mode for jpg, regardless of parameters
			#encoded with jxlg extension, jxlg stands for files that is lossless transcoded from jpeg
		}elseif($_.Extension -eq ".png"){
			cjpegxl $_.FullName "$($_.Directory)/$($_.BaseName)-jxl.jxl" -q $EncodeQuality -s $EncodeSpeed;
			#encoded with jxl extension
		}
	}
}


function JXLdec{
	param(
		[parameter(Position=0)][string]$RootPath=$pwd
	)
	Get-ChildItem -LiteralPath $RootPath *.* -Recurse | ForEach-Object{
		if($_.Extension -eq ".jxlg"){
			djpegxl $_.FullName "$($_.Directory)/$($_.BaseName)-decoded.jpg" -j;
			#decode file that is transcoded from jpeg, if it is not transcoded from jpeg
			#this command will fail
		}elseif ($_.Extension -eq ".jxl") {
			djpegxl $_.FullName "$($_.Directory)/$($_.BaseName)-decoded.jpg"   --jpeg_quality=100 --noise=0;
			#decode any jxl file
		}
	}

}
