for ( $i -ge 1; $i -le 254; $i++ )
	{
	$ip = "192.168.10.$($i)"
	nslookup $ip
	}
