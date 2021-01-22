function RollSingleDice{
	param(
		[Parameter(Position=0)][string]$DiceExperission="nd20"
	)
	[int]$DiceGtZero = 1;
	$DiceArray = $DiceExperission.Split("d");
	
	if($DiceArray[0] -eq "n"){
		$DiceGtZero = -1;
	}
	if($DiceArray[1]){
		$DiceMaxValue=[int]$DiceArray[1];
		$ReVal = Get-Random  -Maximum ($DiceMaxValue + 1) -Minimum 1;
		return $DiceGtZero*$ReVal;
	}else {
		return [int]$DiceArray[0]
	}
}

#This is for roll multiple dices in the same condition.
function RollDice{
	param(
		[Parameter(Position=0)][string[]]$RandomExperissions=@("5d20","d20","-10","nd20")
	)

	[string]$PasteValue="";
	[int]$SumDiceValue=0;

	$HeadExperission = $RandomExperissions[0];
	[int]$TotalNumber = $HeadExperission.Split("d")[0];
	if($TotalNumber -eq 0){$TotalNumber = 1;}
	
	foreach($TempNumber in 1..$TotalNumber){
		[string]$ModifierDetail="Modifier: ";
		$TotalModifier = 0;

		$HeadValue = RollSingleDice $HeadExperission;
		if($RandomExperissions[1]){
			foreach($RandomExperission in $RandomExperissions[1..($RandomExperissions.Length - 1)]){
				$ModifierValue = RollSingleDice $RandomExperission;
				$TotalModifier = $TotalModifier + $ModifierValue;
				$ModifierDetail = $ModifierDetail + "$ModifierValue ";
			}
		}
		Write-Output "D$($HeadExperission.Split('d')[1]) Dice:$TempNumber ($ModifierDetail) Val:$($TotalModifier + $HeadValue)";
		$PasteValue = $PasteValue + "D$($HeadExperission.Split('d')[1]) Dice:$TempNumber ($ModifierDetail) Val:$($TotalModifier + $HeadValue) `n";
		$SumDiceValue = $SumDiceValue + $TotalModifier + $HeadValue;
	}

	if($TotalNumber -gt 1){
		Write-Output "$Executer Total Dice Value: $SumDiceValue";
		$PasteValue = $PasteValue + "Total Dice Value: $SumDiceValue";
	}
	Set-Clipboard $PasteValue;
}

#for roll dices in different conditions
function RollDiceMultiple{
	param(
		[Parameter(Position=0)][string[]]$RandomExperissions=@("d20","d30","nd40","nd50")
	)
	$PasteValue = "";
	$ResultSum = 0;
	foreach($RandomExperission in $RandomExperissions){
		$Value = RollSingleDice $RandomExperission;
		$ResultSum = $ResultSum + $Value;
		Write-Output "Dice $RandomExperission : $Value";
		$PasteValue = $PasteValue + "Dice $RandomExperission : $Value `n";
	}
	Write-Output "SUM: $ResultSum";
	$PasteValue = $PasteValue + "SUM: $ResultSum"
	Set-Clipboard $PasteValue;
}