function RollDice{
	param(
		[Parameter(Position=0)][string]$DiceExperission="1D100+0",
		[Parameter(Position=1)][string]$Executer
	)
	
	[int]$DiceMultipler = 1;
	[int]$DiceModifier = 0;
	[int]$DiceMainRoll = 100;

	$DiceArray = $DiceExperission.Split("d");
	if($DiceArray[0]){
		$DiceMultipler=[int]$DiceArray[0];
	}
	$DiceArrayBackHalf=$DiceArray[1].Split("+");
	$DiceMainRoll=[int]$DiceArrayBackHalf[0];
	if($DiceArrayBackHalf[1]){
		$DiceModifier=[int]$DiceArrayBackHalf[1];
	}

	$ReVal = Get-Random -Count $DiceMultipler -Maximum $DiceMainRoll;
	$ReValState = $ReVal | Measure-Object -AllStats;
	$VersusCount = 0;
	$ReVal | ForEach-Object {
		$DiceVal = $_ + $DiceModifier;
		Write-Output "$Executer roll dice $($ReValState.Count - $VersusCount) (Modifer $DiceModifier):    $($DiceVal)";
		$VersusCount = $VersusCount + 1;
	}
	if($ReValState.Count -gt 1){
		Write-Output "Dice Result Sum: $($ReValState.Sum + $ReValState.Count * $DiceModifier)";
	}


}