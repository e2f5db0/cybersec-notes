# Notes on systems hacking

## Metasploit

Basic usage:

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

# run the selected exploit, scanner, etc.
msf6(module_name)> exploit
msf6(module_name)> run

# list opened sessions
msf6> sessions
# attach to a session
msf6> sessions <number>
```


----------------------------------------------------------------