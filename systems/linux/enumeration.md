# Linux system enumeration

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