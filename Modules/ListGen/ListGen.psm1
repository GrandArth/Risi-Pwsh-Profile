function genlist{
	#([string]$Path = $PWD, [string]$format = "m4a")
	param (
		[parameter(Position=0)][string]$format = "m4a",
		[parameter(Position=1)][string]$Path = $PWD
	)
	[string[]]$InfoList = @();
	[string]$AlbumTemp;
	[string]$AlbumArtistTemp;
	[string]$DiscTemp;
	Get-ChildItem -LiteralPath $Path -Include *.$format | ForEach-Object {
		$TempTrackInfo = mediainfo "$($_.FullName)" --Output=JSON;
		$TempTrackInfo = $TempTrackInfo | ConvertFrom-Json;
		$Album=$TempTrackInfo.media.track.Album;
		If( [string]$AlbumTemp -ne [string]$Album ){
			$InfoList = $InfoList + @("Album: $Album");
			$AlbumTemp = $Album;
		}
		$AlbumArtist=$TempTrackInfo.media.track.Album_Performer;
		If([string]$AlbumArtistTemp -ne [string]$AlbumArtist){
			$InfoList = $InfoList + @("Album Artist: $AlbumArtist");
			$AlbumArtistTemp=  $AlbumArtist;
		}
		$DiscNum=$TempTrackInfo.media.track.Part_Position;
		If([string]$DiscTemp -ne [string]$DiscNum){
			$InfoList = $InfoList + @("Disc: $DiscNum");
			$DiscTemp = $DiscNum;
		}
		[string]$TrackNum = $TempTrackInfo.media.track.Track_Position;
		[string]$TrackTitle = $TempTrackInfo.media.track.Track;
		[string]$TrackArtist = $TempTrackInfo.media.track.Performer;
		if($TrackArtist -eq $AlbumArtist){
			$InfoList = $InfoList + @("$TrackNum	$TrackTitle");
		}else {
			$InfoList = $InfoList + @("$TrackNum	$TrackTitle		By: $TrackArtist");
		}
	}
	$InfoList
	Set-Clipboard $InfoList;
}
