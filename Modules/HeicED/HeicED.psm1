function imgconv{
	param(
		[Parameter(Position=0)]$Q,
		[Parameter(Position=1)][string]$SourceFileFormat,
		[Parameter(Position=2)][string]$TargetFileFormat="heic",
		[string]$TargetDirectory = $PWD.ToString()
	)
	Start-Job -InitializationScript { Import-Module HeicBackflow }  -ScriptBlock {
		param($v1,$v2,$v3,$v4);
		ImageConvention "$v1" $v2 $v3 $v4;
	} -ArgumentList $TargetDirectory,$Q,$SourceFileFormat,$TargetFileFormat;
	
	Get-ChildItem -Attributes Directory -LiteralPath $TargetDirectory -Recurse | ForEach-Object{
		Start-Job -InitializationScript { Import-Module HeicBackflow } -ScriptBlock {
			param($v1,$v2,$v3,$v4);
			ImageConvention "$v1" $v2 $v3 $v4;
		} -ArgumentList "$($_.FullName)",$Q,$SourceFileFormat,$TargetFileFormat;
	}
	Write-Output "在确认所有图片转换结束之后 使用 Get-Job | Remove-Job 来释放任务序列, 请不要关闭本窗口!!!"
}

function fimgconv{
	param(
		[Parameter(Position=0)]$Q,
		[Parameter(Position=1)][string]$SourceFileFormat,
		[Parameter(Position=2)][string]$TargetFileFormat="heic",
		[string]$TargetDirectory = $PWD.ToString()
	)
	Start-Job -InitializationScript { Import-Module HeicBackflow }  -ScriptBlock {
		param($v1,$v2,$v3,$v4);
		FastImageConcention "$v1" $v2 $v3 $v4;
	} -ArgumentList $TargetDirectory,$Q,$SourceFileFormat,$TargetFileFormat;
	Get-ChildItem -Attributes Directory -LiteralPath $TargetDirectory -Recurse | ForEach-Object{
		Start-Job -InitializationScript { Import-Module HeicBackflow } -ScriptBlock {
			param($v1,$v2,$v3,$v4);
			FastImageConcention "$v1" $v2 $v3 $v4;
		} -ArgumentList "$($_.FullName)",$Q,$SourceFileFormat,$TargetFileFormat;
	}
	Write-Output "在确认所有图片转换结束之后 使用 Get-Job | Remove-Job 来释放任务序列, 请勿关闭本窗口!!!"
}

