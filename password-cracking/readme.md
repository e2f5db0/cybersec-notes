# Notes on cracking password hashes

Getting the hash type:

```bash
# pre-installed in Kali distributions
$ hash-identifier [hash]
```

Online tools:

- [CrackStation](https://hashes.com/en/decrypt/hash) – Rainbow tables
- [Hashes.com](https://hashes.com/en/decrypt/hash) – Rainbow tables
  - [hashes.com hash identifier tool](https://hashes.com/en/tools/hash_identifier)

----------------------------------------------------------

To crack hashes in */etc/shadow* john the ripper needs the data in a specific unshadowed format:

```bash
# unshadow is part of the john suite of tools.
# You can pass the whole files or the relevat line from each file.
$ unshadow /etc/passwd /etc/shadow > unshadowed.txt

# sometimes the format must be passed even though unshadowed format should be automatically detected
$ john --wordlist=/usr/share/wordlists/rockyou.txt --format=sha512crypt unshadowed.txt
```

Single crack mode uses word mangling derived from the username & other user data to try different combinations the user could have used to create a weak password.

```bash
# john expects the following format:
# mike:1efee03cdcb96d90ad48ccc7b8666033
$ john --single unshadowed.txt
```

----------------------------------------------------

Many passwords used in the healthcare industry are something like "Fall2026" or "Spring2026".

First letters are typically capitalized and the special character is "!" at the end of the password. (i.e. Polopassword1!)

-----------------------------------------------------

## Hydra

### ssh

`hydra -l <username> -P wordlists/passwords.txt <domain_or_ip> -t 4 ssh`

| option | Description |
| ------ | ----------- |
| -l     | specifies the username for login |
| -P     | indicates a list of passwords |
| -t     | sets the number of threads to spawn |

### Web form

`sudo hydra -l <username> -P <wordlist> <domain_or_ip> http-post-form "<path>:<login_credentials>:<invalid_response>"`

| option | Description |
| ------ | ----------- |
| -http-post-form | type of the form is POST |
| < path > | the login page URL, for example `login.php` |
| <login_credentials> | username and password, for example `username=^USER^&password=^PASS^` |
| <invalid_response> | part of the response when the login fails |
| -V | verbose output for every attempt |
| -s | optional port number |

`hydra -l <username> -P <wordlist> <domain> http-post-form "/login:username=^USER^&password=^PASS^:F=incorrect" -V`