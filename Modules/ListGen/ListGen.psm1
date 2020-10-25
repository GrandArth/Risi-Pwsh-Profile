function genlist{
	param (
		[parameter(Position=0)][string]$FileFormat = "*.m4a,*.flac,*.opus,*.mp3",
		[parameter(Position=1)][string]$Path = $PWD
	)

	$ObjectList = New-Object System.Collections.Generic.List[System.Object];
	$OutputList = New-Object System.Collections.Generic.List[string];

	Get-ChildItem -LiteralPath $Path -Include $FileFormat.Split(",") | ForEach-Object {
		$TempTrackInfo = mediainfo "$($_.FullName)" --Output=JSON;
		$TempTrackInfo = $TempTrackInfo | ConvertFrom-Json;
		$TempTrackInfo=[PSCustomObject]@{
			AlbumPerformer = $TempTrackInfo.media.track.Album_Performer[0]
			AlbumName = $TempTrackInfo.media.track.Album[0]
			DiscNumber=[int]$TempTrackInfo.media.track.Part_Position[0] + [int]$TempTrackInfo.media.track.Part[0]
			#some container user Part to indicate disc, some use Part+Postion, if not exist, [int] will set it to zero
			#so simply add them up will provide accurate result
			TrackNumber=[int]$TempTrackInfo.media.track.Track_Position[0]
			TrackTitle=$TempTrackInfo.media.track.Track[0]
			TrackPerformer=$TempTrackInfo.media.track.Performer[0]
		}

		$ObjectList.Add($TempTrackInfo);
	}
#man.. this is the most shit pipeline i have ever written!
	$ObjectList | Group-Object -Property AlbumPerformer | ForEach-Object {
		$OutputList.Add("`nAlbum Artist(s): $($_.Name)");
		$_.Group | Group-Object -Property AlbumName| ForEach-Object {
			$OutputList.Add("	Album: $($_.Name)");
			$_.Group | Group-Object -Property DiscNumber| ForEach-Object {
				$OutputList.Add("		Disc Number: $($_.Name)");
				$_.Group | Sort-Object -Property TrackNumber |ForEach-Object {
					if($_.AlbumPerformer -eq $_.TrackPerformer){
						$OutputList.Add("			$($_.TrackNumber) $($_.TrackTitle)");
					}else {
						$OutputList.Add("			$($_.TrackNumber) $($_.TrackTitle) By: $($_.TrackPerformer)");
					}
				}
			}
		}
	}
	$OutputList
	Set-Clipboard $OutputList;
}