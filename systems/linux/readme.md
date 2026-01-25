# Systems hacking stages (linux)

## Information gathering

```bash
# the most basic aggressive scan
$ nmap -A -T4 <TARGET_IP>

# Get operating system info with stealth scan
$ nmap -sS -A -T4 -O <TARGET_IP>
```

---

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
msf6> use exploits/linux/smtp/exim4_dovecot_exec.rb
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
# show operating system's information
$ cat /etc/*-release
$ lsb_release -a
$ hostnamectl

# kernel version and system architecture
$ uname -a

# identify which processes are running as root
$ ps aux|grep root

# list installed software
$ ls /usr/local
$ ls /usr/local/bin
$ ls /opt
$ ls /var
$ ls /usr/src
$ dpkg -l
$ rpm -qa

# show cron information
$ crontab -l
$ ls -al /var/spool/cron
$ ls -al /etc/ | grep cron
$ ls -al /etc/cron*
$ cat /etc/cron*
$ cat /etc/at.allow
$ cat /etc/at.deny
$ cat /etc/cron.allow
$ cat /etc/cron.deny
$ cat /etc/crontab
$ cat /etc/anacrontab
$ cat /var/spool/crontabs/root
```

### User and group enumeration

```bash
# show current user
$ whoami

# list users
$ cat /etc/passwd

# list current user's groups
$ groups <username>

# search SUID binaries which can be exploited and run with root privileges
$ find / -perm -u=s -type f 2>/dev/null
```

### Network enumeration

```bash
# list network interfaces
$ ifconfig

# show routing table
$ route

# list currently running services & ports
$ netstat -ant
```

Enumeration tools:
```bash
# move the meterpreter session to the background
meterpreter> CTRL-Z 

# metasploit's own exploit suggester module
msf6> use post/multi/recon/local_exploit_suggester

msf6> set SESSION <id>
msf6> run

# go back to the meterpreter session
msf6> sessions <id>
```
- LinEnum
    - https://github.com/rebootuser/LinEnum
    ```bash
    # basic usage
    $ ./LinEnum.sh -t -r <report-name>
    # search using a keyword
    $ ./LinEnum.sh -k password
    ```
- Linux Exploit Suggester
    - https://github.com/mzet-/linux-exploit-suggester
    ```bash
    $ ./linux-exploit-suggester.sh
    ```
- Linux Smart Enumeration
    - https://github.com/diego-treitos/linux-smart-enumeration
- Linux Priv Checker
    - https://github.com/sleventyeleven/linuxprivchecker
    ```bash
    $ python linuxprivchecker.py -w -o linuxprivchecker.log
    ```
- LinPEAS
    - https://github.com/carlospolop/PEASS-ng/tree/master/linPEAS

---

## Privilege escalation / persistence

Drop a ssh public key into *~/.ssh/authorized_keys* for a more stable backdoor compared to reverse shells

---