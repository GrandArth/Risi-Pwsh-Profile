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
	$ipv6add=$ipv6add.ToString().Trim().split()[1].split("/")[0];
	Write-Output "`n Warning: Current IPV6 is $ipv6add";
    #namesilo
    Write-Output "`n Warning: Updating NameSilo"
    UpdateNameSilo($ipv6add);
	#dynv6
	Write-Output "`n Warning: Updating for dynv6";
	curl "https://ipv6.dynv6.com/api/update?ipv6=auto&token=xxxxxxxxxxxxxxxxx&zone=xxxxxxxxxxxxxxxxxxxxxx";
	Write-Output "";
	#freeDNS afraid
	Write-Output "`n Warning: Updating for Sync Free DNS";
	curl http://v6.sync.afraid.org/u/xxxxxxxxxxxxxxxxxxxxxxxxxxx/;
	#noip
	Write-Output "`n Warning: Updating for NOIP";
	curl "https://xxxxxxxxxxxxxxxxxxxxxx@dynupdate.no-ip.com/nic/update?hostname=xxxxxxxxxxxxxxxxxx&myipv6=$($ipv6add)";
}
