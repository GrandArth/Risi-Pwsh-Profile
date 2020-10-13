function TBTblocklist(){
[string]$Username = "?";
[string]$Password="?";
[string]$ListAddress="?";
[string[]]$ClientList=@('Xunlei','Thunder','-XL0012-','-DL3760-','QQDownload','-FD51YC-');
Get-Date;

$CurrentTorrents=transmission-remote --auth "$($Username):$($Password)" -t all -l| Select-Object -SkipLast 1 ;
$CurrentTorrents= $CurrentTorrents.Trim() -replace '\s{2,}',',' | ConvertFrom-Csv;
$CurrentTorrents | ForEach-Object {

    [bool]$ClientNoticed=0;
    $CurrentPeers=transmission-remote --auth "$($Username):$($Password)" -t $($_.ID) -ip;
    $CurrentPeers = $CurrentPeers.Trim() -replace '\s{2,}',',' | ConvertFrom-Csv;
    #$CurrentPeers = $CurrentPeers | Where-Object {[string]$_.Address -ne "Address"};
    $CurrentPeers | ForEach-Object{
        if($null -ne $_.Client ){
            if( ($ClientList -contains $_.Client.split(' ')[0]) -And !(Select-String -Path $ListAddress -Pattern "$($_.Address)" -SimpleMatch -Quiet)  ){     
                Write-Output "$($_.Address.ToString()) - $($_.Address.ToString()),0,$($_.Client.ToString())" >> $ListAddress;
                Write-Output "$($_.Address.ToString()) with $($_.Client.ToString()) Client detected, adding.";
                $ClientNoticed=$true;
            }elseif ( ($ClientList -contains $_.Client.split(' ')[0]) -And (Select-String -Path $ListAddress -Pattern "$($_.Address)" -SimpleMatch -Quiet) ) {
                Write-Output "$($_.Address.ToString()) with $($_.Client.ToString()) Client detected, but is already in the list, marked for restarting.";
                $ClientNoticed=$true;
            }
        }else{
            Write-Output "Invalid formatted object detected, skipping this object."
        }
    }

switch ( $_ ) {
    { ($_.Status.ToString().Contains("Seeding")) -And ($ClientNoticed) } { 
        transmission-remote --auth "$($Username):$($Password)" --blocklist-update;
		Write-Output "Blocklist updated for Torrent $($_.ID), ready to restart to apply";
        transmission-remote --auth "$($Username):$($Password)" -t $($_.ID) -S;
	    Write-Output "Torrent $($_.ID) stopped!";
        Start-Sleep -s 2;
        transmission-remote --auth "$($Username):$($Password)" -t $($_.ID) -s;
        Write-Output "Torrent $($_.ID) started!";
        Break;
    }
    { ($_.Status.ToString().Contains("Up")) -And ($ClientNoticed) }{
        transmission-remote --auth "$($Username):$($Password)" --blocklist-update;
        Write-Output "Blocklist updated for Torrent $($_.ID), but no restarting due to active downloding.";
        Break;
    }
    { ($_.Status.ToString().Contains("Idle")) -And ($ClientNoticed) }{
        transmission-remote --auth "$($Username):$($Password)" --blocklist-update;
        Write-Output "Torrent $($_.ID) is Idle, only updating blocklist.";
        Break;
    }
    Default {
        Write-Output "Torrent $($_.ID) meets exception conditions, no action taken."
    }
}
}
}
