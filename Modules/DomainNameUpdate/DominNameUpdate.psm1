function UpdateNameSilo($ipaddr){
	$RequestedXml = curl "???";
    $RequestedRecords= $RequestedXml | Select-Xml -XPath "/namesilo/reply/resource_record" | Select-Object -ExpandProperty Node;
    foreach($Record in $RequestedRecords){
        If($Record.type -eq "AAAA"){
        Write-Output "`n Current record id: $($Record.record_id)";
        curl "https://www.namesilo.com/api/dnsUpdateRecord?version=1&type=xml&key=xxxxxxxxx&domain=xxxxxxxxxxxxxx.xxxxxxxxxxxxx&rrid=$($Record.record_id)&rrhost=$($Record.host.Split(".")[0])&rrvalue=$($ipaddr)&rrttl=xxxxxxx";
        }else{
            Write-Output "`n Record $($Record.record_id) has Type: $($Record.Type) not AAAA, not updating this record";
        }
    }
}

function RefreshNameSilo {
	$ipv6add=ip -6 addr show eth0 | Select-String -Pattern "global";
	#$ipv6add=$ipv6add.ToString().Trim().split()[1].split("/")[0];
    $ipv6add = $ipv6add[0].ToString().Trim().Split(" ")[1].Split("/")[0]
	Write-Output "`n Warning: Current IPV6 is $ipv6add";
    #namesilo
    Write-Output "`n Warning: Updating NameSilo"
    UpdateNameSilo($ipv6add);
}
