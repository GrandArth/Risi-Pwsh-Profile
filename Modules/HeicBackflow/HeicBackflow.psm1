function HeicPreProcession($FilePath){
	$extentmark = 0;
	$imwidth=magick identify -ping -format "%w" "$($FilePath)"
	$imwidth=[int]$imwidth;
	If(($imwidth)%2 -ne 0){
		$imwidth=$imwidth+1;
		$extentmark=1;
	}
	$imheight=magick identify -ping -format "%h" "$($FilePath)";
	$imheight=[int]$imheight;
	If(($imheight)%2 -ne 0){
		$imheight=$imheight+1;
		$extentmark=1;
	}
	If($extentmark){
		magick "$($FilePath)" -gravity center -strip -extent "($imwidth)x($imheight)" -quality 100 "$($FilePath)";
	}
}
function HeicTranSourceFileFormation($FilePath,$FileNoExtensionPath,$CRTValue){
	ffmpeg -i "$($FilePath)"  -crf $CRTValue -vf "crop=trunc(iw/2)*2:trunc(ih/2)*2" -pix_fmt yuv420p -sws_flags spline+accurate_rnd+full_chroma_int -color_range 1 -colorspace 5 -color_primaries 5 -color_trc 6   -f hevc "$($FileNoExtensionPath).hvc";
	MP4Box -add-image "$($FileNoExtensionPath).hvc:primary" -ab heic -new "$($FileNoExtensionPath).heic";
}
#ffmpeg -i $_.FullName  -crf $crfval  -pix_fmt yuv444p -sws_flags spline+accurate_rnd+full_chroma_int -color_range 1 -colorspace 5 -color_primaries 5 -color_trc 6  -f hevc "$($_.Directory)\$($_.Basename).hvc";
#ffmpeg -i $_.FullName  -crf $crfval  -pix_fmt yuv444p10le -sws_flags spline+accurate_rnd+full_chroma_int -vf "colormatrix=bt470bg:bt709" -color_range 1 -colorspace 1 -color_primaries 1 -color_trc 1   -f hevc "$($_.Directory)\$($_.Basename).hvc";



function ImageConvention($TargetDirectory,$Q,$SourceFileFormat,$TargetFileFormat){
	If($TargetFileFormat -eq "heic"){
		Get-ChildItem -LiteralPath $TargetDirectory *.$SourceFileFormat |ForEach-Object{
			HeicPreProcession "$($_.FullName)";
		}
		Get-ChildItem -LiteralPath $TargetDirectory *.$SourceFileFormat |ForEach-Object{
			HeicTranSourceFileFormation "$($_.FullName)" "$($_.Directory)\$($_.Basename)" $Q;
			Remove-Item -LiteralPath "$($_.Directory)\$($_.Basename).hvc";
		}
	}Else{
		Get-ChildItem -LiteralPath $TargetDirectory *.$SourceFileFormat |ForEach-Object{
			magick "$($_.FullName)" -quality $Q -strip "$($_.Directory)\$($_.Basename).$TargetFileFormat";
		}
	}
}	


function FastImageConcention($TargetDirectory,$Q,$SourceFileFormat,$TargetFileFormat){
	If($TargetFileFormat -eq "heic"){
		Get-ChildItem -LiteralPath $TargetDirectory *.$SourceFileFormat |ForEach-Object{
			HeicTranSourceFileFormation "$($_.FullName)" "$($_.Directory)\$($_.Basename)" $Q;
			Remove-Item -LiteralPath "$($_.Directory)\$($_.Basename).hvc";
		}
	}Else{
		Get-ChildItem -LiteralPath $TargetDirectory *.$SourceFileFormat |ForEach-Object{
			magick "$($_.FullName)" -quality $Q -strip "$($_.Directory)\$($_.Basename).$TargetFileFormat";
		}
	}
}


