Function Get-VerseoftheDay
	{
	$Scripture = (Get-BibleVerse -VerseOfTheDay -Type Json | ConvertFrom-Json)[0] 
	$book = $Scripture.bookname 
	$chap = $Scripture.chapter 
	$verse = $Scripture.verse 
	$ref = $book+" "+$chap+":"+$verse
	$txt = ('"' + $Scripture.text + '"').replace(' "','"')
	$space = " "*($txt.length - $ref.length)
        #$border = ("="*$($txt.length)).substring(0, [System.Math]::Min(240, $txt.length))
        Write-Host ("="*($txt.length)) -ForegroundColor White
	Write-Host $txt -ForegroundColor White
	Write-Host (" "*($txt.length))
	Write-Host $space$ref -ForegroundColor Yellow
	Write-Host ("="*($txt.length)) -ForegroundColor White
	}

Function Color-LS
{
    $regex_opts = ([System.Text.RegularExpressions.RegexOptions]::IgnoreCase `
          -bor [System.Text.RegularExpressions.RegexOptions]::Compiled)
    $fore = $Host.UI.RawUI.ForegroundColor
    $compressed = New-Object System.Text.RegularExpressions.Regex(
          '\.(zip|tar|gz|rar|jar|war)$', $regex_opts)
    $executable = New-Object System.Text.RegularExpressions.Regex(
          '\.(exe|bat|cmd|py|pl|ps1|psm1|vbs|rb|reg)$', $regex_opts)
    $text_files = New-Object System.Text.RegularExpressions.Regex(
          '\.(txt|cfg|conf|ini|csv|log|xml|java|c|cpp|cs)$', $regex_opts)

    Invoke-Expression ("Get-ChildItem $args") | ForEach-Object {
        if ($_.GetType().Name -eq 'DirectoryInfo') 
        {
            $Host.UI.RawUI.ForegroundColor = 'Cyan'
            echo $_
            $Host.UI.RawUI.ForegroundColor = $fore
        }
        elseif ($compressed.IsMatch($_.Name)) 
        {
            $Host.UI.RawUI.ForegroundColor = 'DarkGreen'
            echo $_
            $Host.UI.RawUI.ForegroundColor = $fore
        }
        elseif ($executable.IsMatch($_.Name))
        {
            $Host.UI.RawUI.ForegroundColor = 'Yellow'
            echo $_
            $Host.UI.RawUI.ForegroundColor = $fore
        }
        elseif ($text_files.IsMatch($_.Name))
        {
            $Host.UI.RawUI.ForegroundColor = 'White'
            echo $_
            $Host.UI.RawUI.ForegroundColor = $fore
 Write-Host "_"
	       }
        else
        {
            echo $_
        }
    }
}

Function Get-UserVariable ($Name = '*')
	{
	# these variables may exist in certain environments (like ISE, or after use of foreach)
	$special = 'ps','psise','psunsupportedconsoleapplications', 'foreach', 'profile'
 	$ps = [PowerShell]::Create()
	$null = $ps.AddScript('$null=$host;Get-Variable') 
	$reserved = $ps.Invoke() |
 	Select-Object -ExpandProperty Name
	$ps.Runspace.Close()
	$ps.Dispose()
	Get-Variable -Scope Global |
	Where-Object Name -like $Name |
	Where-Object { $reserved -notcontains $_.Name } |
	Where-Object { $special -notcontains $_.Name } |
	Where-Object Name
	}

Function Get-FolderSize
	{
	param(
	[parameter(ValueFromPipelineByPropertyName)]
	$FullName = (pwd),
	[ValidateSet('TB', 'GB', 'MB', 'KB')]
	$unit = "GB"
	)
	$munit = "1$($unit)"
	$item = Get-Item $Fullname
	$colitems = (Get-ChildItem $Fullname -R | Measure-Object -property length -sum)
	$item | Add-Member -MemberType NoteProperty -Name Size -Value ("{0:N2}" -f ($colItems.sum / $munit) + " $($unit)")
	$item | fl Name, Size
	}

Function Get-WeatherPicture($City="McKinney") 
	{
	if ($City -eq $null)
		{
	        $City = Read-Host "Specify City"
	    	}
	(Invoke-WebRequest "http://wttr.in/$City" -UserAgent curl).content -split "`n"
	}


Function Get-WeekOfYear
	{
	Get-Date -UFormat %V
	}
