# Notes on Digital Forensics and Incident Response

### Disk images

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

## Malware analysis / Reversing

- [REMnux VM](https://remnux.org/) – A linux toolkit for malware analysis

### Static analysis
- [CAPA](https://github.com/mandiant/capa) – detects capabilities in executable files (open-source)
- [CAPA analysis web explorer](https://mandiant.github.io/capa/explorer/#/)
- [Javascript Obfuscator](https://codebeautify.org/javascript-obfuscator)
- [Javascript Deobfuscator](https://obf-io.deobfuscate.io/)
- [CyberChef](https://gchq.github.io/CyberChef/)

#### Oledump.py

```bash
# list data streams of a file
# streams might contain embedded scripts
$ oledump.py <filepath>
```

The M in the following example output means there is a macro in the stream number 4:

![oledump](../CTF-notes/images/oledump-py.png)

```bash
# select the 4th data stream
# auto-decompress any VBA macros into a more readable format
oledump.py agenttesla.xlsm -s 4 --vbadecompress
```

Oledump outputs the script which can then be analyzed further using CyberChef for example.

#### Volatility (windows plugins)

```bash
# basic usage
$ vol3 -f memory_image_file.mem

# list processes in a tree
$ vol3 -f memory_image_file.mem windows.pstree.PsTree

# list all curently active processes in the machine
$ vol3 -f memory_image_file.mem windows.pslist.PsList

# list process command line arguments
$ vol3 -f memory_image_file.mem windows.cmdline.CmdLine

# scan for file objects
# the output can be huge
$ vol3 -f memory_image_file.mem windows.filescan.FileScan

# list loaded modules (dll)
$ vol3 -f memory_image_file.mem windows.dlllist.DllList

# scan for processes
$ vol3 -f memory_image_file.mem windows.psscan.PsScan

# list memory ranges that potentially contain injected code
$ vol3 -f memory_image_file.mem windows.malfind.Malfind
```

```bash
# loop all of the above into text files in -q quiet mode (no terminal output)
# replace IMAGE_FILE and FILENAME
for plugin in windows.malfind.Malfind windows.psscan.PsScan windows.pstree.PsTree windows.pslist.PsList windows.cmdline.CmdLine windows.filescan.FileScan windows.dlllist.DllList; do vol3 -q -f IMAGE_FILE.mem $plugin > FILENAME.$plugin.txt; done
```

```bash
# preprocess the memory image for analysis with the strings utility
# extract printable ASCII text
strings IMAGE_FILE.mem > IMAGE_FILE.strings.ascii.txt
# ASCII 16-bit little-endian
strings -e l IMAGE_FILE.mem > IMAGE_FILE.strings.ascii.txt
# ASCII 16-bit big-endian
strings -e b IMAGE_FILE.mem > IMAGE_FILE.strings.ascii.txt
```

### Dynamic Analysis

REMnux contains the INetSim: Internet Services Simulation Suite that can be used to analyze the network traffic a malicious software tries to generate.

The config file is located in /etc/inetsim/inetsim.conf

```bash
# inetsim will generate a report in /var/log/inetsim/report after stopping the simulation
sudo inetsim
```