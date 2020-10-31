function RDI{
	#RollDice
	param(
		[Parameter(Position=0)][int]$MaxVal=100,
		[Parameter(Position=1)][string]$Protagonist="",
		[Parameter(Position=2)][int]$Check,
		[Parameter(Position=3)][string]$Object="Criterion"
	)
	$RandomVal = Get-Random -Maximum $Maxval;
	if($Check -and ($RandomVal -ge $Check) ){
		Write-Output "$($Protagonist) roll dice: $($RandomVal), won against $($Object) ($($Check))!";
	}elseif ($Check -and ($RandomVal -lt  $Check) ) {
		Write-Output "$($Protagonist) roll dice: $($RandomVal), lost against $($Object) ($($Check))!";
	}else{
		Write-Output "$($Protagonist) roll dice: $($RandomVal)";
	}
	


}

function MRDI {
	#Multi RollDice
	param (
		[Parameter(Position=0)][int]$MaxVal,
		[Parameter(Position=1)][int]$RollTime,
		[Parameter(Position=2)][string]$Protagonist
	)
	if($Protagonist){
		Write-Output "$Protagonist roll multi dices:"
	}else{
		Write-Output "Multi Roll:"
	}
	[int]$Counter=0;
	Get-Random -Maximum $MaxVal -Count $RollTime | ForEach-Object{
		Write-Output "Dice $Counter : $($_)";
		$Counter = $Counter + 1;
	}
	
}