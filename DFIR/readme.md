# Notes on Digital Forensics and Incident Response

### 🛠️ Tools & Services

- [CyberChef](https://gchq.github.io/CyberChef/)
- FTK Imager – disk images of Windows operating systems
- [Autopsy](https://www.autopsy.com/) – open-source digital forensics platform, conduct an extensive analysis of an image
- [DumpIt](https://www.toolwar.com/2014/01/dumpit-memory-dump-tools.html) – for taking a memory image from a Windows OS
- [Volatility](https://volatilityfoundation.org/) – open-source tool for analyzing memory images

### Windows Event Viewer

| Event ID | Description |
| -------- | ----------- |
| 4624     | A user account successfully logged in |
| 4625     | A user account failed to login |
| 4634     | A user account successfully logged off |
| 4720     | A user account was created |
| 4724     | An attempt was made to reset an account’s password |
| 4722     | A user account was enabled |
| 4725     | A user account was disabled |
| 4726     | A user account was deleted |
| 104      | Event log was cleared |

### Linux logs

- /var/log/httpd: Contains HTTP Request  / Response and error logs.
- /var/log/cron: Events related to cron jobs are stored in this location.
- /var/log/auth.log and /var/log/secure: Stores authentication-related logs.
- /var/log/kern: This file stores kernel-related events.

### Malware analysis / Reversing

- [CAPA](https://github.com/mandiant/capa) – detects capabilities in executable files (open-source)
- [CAPA analysis web explorer](https://mandiant.github.io/capa/explorer/#/)
- [Javascript Obfuscator](https://codebeautify.org/javascript-obfuscator)
- [Javascript Deobfuscator](https://obf-io.deobfuscate.io/)