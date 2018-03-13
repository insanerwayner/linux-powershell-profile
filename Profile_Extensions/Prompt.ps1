Function prompt
	{
	if ( $host.name -eq "ConsoleHost" )
		{
		$date = (get-date -format 'ddd MMM dd')
		$time = (get-date -format ' hh:mm:ss tt')
		$location = ((get-location).path).tostring()
		$location = $location.replace('Microsoft.PowerShell.Core\FileSystem::','')
		$location = $location.replace('/home/wayne','~')
		$location = $location.replace('.config/powershell/Scripts','Scripts')
		$location = $location.replace('.config/powershell','PSHome')
		#$location = $location.replace('\','/')
		#$location = $location.replace('C:','')
		Write-Host $date -f Green -nonewline;write-host $time -f Yellow -nonewline;write-host " $location>" -f Cyan -NoNewline
		return " "
		}
	}


