Function Launch-Video($VideoID)
	{
	$url = "https://www.youtube.com/embed/$VideoID"
	$vlc = vlc $url &
	}

Function Search-YouTube($query, $results=10)
    {
    $params = @{
		type='video';
		q=$query;
                part='snippet';
                maxResults=$results;
                key='AIzaSyDTx7_0Xl09t4adX06h2pmJrsDVCqxtb1A'  
		}   

    $response = Invoke-RestMethod -Uri https://www.googleapis.com/youtube/v3/search -Body $params -Method Get
    for ( $i=1; $i -le $Response.items.count; $i++)
        {
        Write-Host "$i. $($response.items[$i-1].snippet.title)" -ForegroundColor Cyan
        }
    $Selection = Read-host "Selection"
    Launch-Video -VideoID ($response.items[$selection-1].id.videoId)
    }

Function Get-ClosingTime
    {
    $ClosingTime = Get-Date "$(Get-Date -Format "MM-dd-yy") 5:00PM"
    while ( (Get-Date) -le $ClosingTime )
            {
            $Date = Get-Date 
            $Countdown = $ClosingTime - $Date
            Write-Host "`r$(Get-Date $Date -Format "hh:mm:ss") Countdown: -$($Countdown.Hours):$($Countdown.Minutes):$($Countdown.Seconds):$($Countdown.milliseconds)   " -ForegroundColor Yellow -NoNewLine
            }
    sd -f
    }
