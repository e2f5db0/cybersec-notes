# Linux system enumeration

### OS and Filesystem

`pwd`

`ls /`

`env`

`uname -a`

`lsb_release -a`

`hostname`

### User and Groups Discovery

`id`

`whoami`

`w`

`last`

`cat /etc/sudoers`

`cat /etc/passwd`

### Process and Network Discovery

`ps aux`

`top`

`ip a`

`ip r`

`arp -a`

`ss -tlnp`

`netstat -tlnp`

### Cloud or Sandbox Discovery

`systemd-detect-virt`

`lsmod`

`uptime`

`pgrep "<edr-or-sandbox>"`

-----------------------------------------

*/etc/shadow* file prefixes (hash types)

| Prefix | Algorithm |
| ------ | --------- |
| \$y$    | yescrypt  |
| \$gy$   | gost-yescrypt |
| \$7$, \$9$ | scrypt |
| \$2b$, \$2y$, \$2a$, \$2x$ | bcrypt |
| \$6$    | sha512crypt SHA-512 (Unix) |
| \$md$   | SunMD5    |
| \$1$    | md5crypt  |