# Profile Extensions

Get-ChildItem ~/.config/powershell/Profile_Extensions -File *".ps1" | ForEach-Object { . $_.FullName; Set-Variable -Name $_.basename -Value $_.FullName }

# Startup

Get-VerseoftheDay
Output-Calendar


