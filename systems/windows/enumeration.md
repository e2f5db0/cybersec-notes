# System enumeration | Incident response

Cheat sheet of commands for gathering system information & other useful sysadmin stuff

tip: pipe output to `more` or `less` for better UX on the CLI

| Linux  | Windows |
| -----  | ------- |
| `pwd`  | `cd`    |
| `mv`   | `move`  |
| `cd`   | `copy`  |
| `dir`  | `dir`   |
| `tree` | `tree`  |
| `mkdir`| `mkdir` |
| `cat`  | `type`  |
| `rm`   | `del`, `erase` |
| --help | /?      |

## Windows

`set` – check the path where commands are run

`ver` – OS version

`sysinfo` – various info about the system

`driverquery` – list of installed device drivers

`ipconfig /all` – network information

`tracert` – trace route for network packets

`nslookup <target_domain> <dns_server>` – DNS records for a domain from a specific dns server

`netstat` – current network connections
  - `-a` all established connections and listening ports
  - `-b` program associated with each listening port and established connection
  - `-o` process ID (PID) associated with the connection
  - `-n` uses a numerical form for addresses and port numbers

`tasklist` – list running processes

`taskkill /PID <target_pid>` – kill target process

`chkdsk` – checks the file system and disk volumes for errors and bad sectors

`sfc /scannow` – scans system files for corruption and repairs them if possible

`shutdown []`
  - `/s` shut down the system
  - `/r` restart the system
  - `/a` abort scheduled shutdown 

### Powershell

`Get-ChildItem -Path "C:\Users\"` – list users

`Get-ComputerInfo` – operating system information, hardware specifications, BIOS details, and more

`Get-LocalUser` – lists all the local user accounts on the system

`Get-NetIPConfiguration` – detailed information about the network interfaces

`Get-NetIPAddress` – details for all IP addresses configured on the system

`Get-Process` – lists all currently running processes

`Get-Service` – status of services on the machine

`Get-NetTCPConnection` – displays current TCP connections

`Get-FileHash -Path <filepath>` – generate file hashes

`Get-Item -Path "<filepath>" -Stream *` – view the Alternate Data Streams (ADS) attached to a file

`Invoke-Command -FilePath <filepath>` – executes commands on remote (or local) machines
  - `Invoke-Command -ComputerName Server01 -Credential Domain01\User01 -ScriptBlock { <cmdlet_name> }` (remote machine in Active Directory domain)