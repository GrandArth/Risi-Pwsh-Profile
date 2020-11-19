function RollSingleDice{
	param(
		[Parameter(Position=0)][string]$DiceExperission="nd20"
	)
	$DiceArray = $DiceExperission.Split("d");
	[int]$DiceGtZero = 1;
	if($DiceArray[0] -eq "n"){
		$DiceGtZero = -1;
	}
	if($DiceArray[1]){
		$DiceMaxValue=[int]$DiceArray[1];
		$ReVal = Get-Random  -Maximum $DiceMaxValue;
		return $DiceGtZero*$ReVal;
	}else {
		return [int]$DiceArray[0]
	}
}

function RollDice{
	param(
		[Parameter(Position=0)][string[]]$RandomExperissions=@("5d20","d20","-10","nd20"),
		[Parameter(Position=1)][string]$Executer
	)

	$HeadExperissions = $RandomExperissions[0];
	[int]$TotalNumber = $HeadExperissions.Split("d")[0];
	if($TotalNumber -eq 0){
		$TotalNumber = 1;
	}
	[int]$SumDiceValue=0;

	while($TotalNumber -ne 0){
		$TotalNumber = $TotalNumber - 1;
		$HeadValue = RollSingleDice $HeadExperissions;
		[int]$ModifierIndexer = 1;
		$TotalModifier = 0;
		[string]$ModifierDetail="Modifier: ";
		while($RandomExperissions[$ModifierIndexer]){
			$ModifierValue = RollSingleDice $RandomExperissions[$ModifierIndexer];
			$TotalModifier = $TotalModifier + $ModifierValue;
			$ModifierDetail = $ModifierDetail + "$ModifierValue ";
			$ModifierIndexer = $ModifierIndexer + 1
		}
		Write-Output "$Executer Dice:$TotalNumber ($ModifierDetail) Val:$($TotalModifier + $HeadValue)";
		$SumDiceValue = $SumDiceValue + $TotalModifier + $HeadValue;
	}
	Write-Output "$Executer Total Dice Value: $SumDiceValue";
}