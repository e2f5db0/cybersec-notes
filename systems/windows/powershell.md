# Powershell cheat sheet

`Get-Help <cmdlet> -examples` – detailed information about cmdlets

`Get-Alias` – list all available cmdlet aliases

`Get-Content` (cat) – Retrieves (gets) the content of a file and displays it in the console

`Set-Location -Path` (cd, chdir) – Changes (sets) the current working directory

`Get-Command"` - list all available cmdlets, functions, aliases, and scripts

`Find-Module -Name "<cmdlet_name>*"` – find cmdlets from online repositories. The wildcard matches partial names

`Install-Module -Name "<cmdlet_name>"` – install cmdlets

`Get-ChildItem` (ls) – list the files and directories in specified location
 - `Get-ChildItem | Sort-Object Length`
 - `Get-ChildItem | Where-Object -Property "Extension" -eq ".txt"`
 - `Get-ChildItem | Where-Object -Property "Name" -like "example*"`
 - `Get-ChildItem | Select-Object Name, Length`
 - `Get-ChildItem | Sort-Object Length -Descending | Select-Object -First 1` – display the largest file

`New-Item -Path "<path>" -ItemType "File | Directory"` (ni) – create files & directories

`Remove-Item -Path "<path>"` (rm) – remove files & directories

`Copy-Item -Path "<from>" -Destination "<to>"` (cp) – copy files & directories

`Move-Item -Path "<from>" -Destination "<to>"` (mv) – move items

`Select-String -Path "<path>" -Pattern "example"` – search text pattern within files (regex support)

## Malicious behaviour

`powershell -WindowStyle hidden` – hide the powershell window, useful when running a malicious script

`powershell -executionpolicy bypass` – temporarily ignore the script execution restriction in powershell