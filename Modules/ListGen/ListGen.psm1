function genlist{
	param (
		[parameter(Position=0)][string]$format = "m4a",
		[parameter(Position=1)][string]$Path = $PWD
	)

	$ObjectList = New-Object System.Collections.Generic.List[System.Object];
	$OutputList = New-Object System.Collections.Generic.List[string];

	Get-ChildItem -LiteralPath $Path -Include *.$format | ForEach-Object {
		$TempTrackInfo = mediainfo "$($_.FullName)" --Output=JSON;
		$TempTrackObject = $TempTrackInfo | ConvertFrom-Json;
		$TrackObjectDefine=[PSCustomObject]@{
			AlbumPerformer = $TempTrackObject.media.track.Album_Performer[0]
			AlbumName = $TempTrackObject.media.track.Album[0]
			DiscNumber=[int]$TempTrackObject.media.track.Part_Position[0]
			TrackNumber=[int]$TempTrackObject.media.track.Track_Position[0]
			TrackTitle=$TempTrackObject.media.track.Track[0]
			TrackPerformer=$TempTrackObject.media.track.Performer[0]
		}

		$ObjectList.Add($TrackObjectDefine);
	}
#man.. this is the most shit pipeline i have ever written!
	$ObjectList | Group-Object -Property AlbumPerformer | ForEach-Object {
		$OutputList.Add("Album Artist(s)	$($_.Name)");
		$_.Group | Group-Object -Property AlbumName| ForEach-Object {
			$OutputList.Add("Album	$($_.Name)");
			$_.Group | Group-Object -Property DiscNumber| ForEach-Object {
				$OutputList.Add("Disk Number	$($_.Name)");
				$_.Group | Sort-Object -Property TrackNumber |ForEach-Object {
					if($_.AlbumPerformer -eq $_.TrackPerformer){
						$OutputList.Add("$($_.TrackNumber)	$($_.TrackTitle)");
					}else {
						$OutputList.Add("$($_.TrackNumber)	$($_.TrackTitle)	By: $($_.TrackPerformer)");
					}
				}
			}
		}
	}
	$OutputList
	Set-Clipboard $OutputList;
}