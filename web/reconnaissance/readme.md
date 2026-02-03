# Reconnaissance, enumeration & scanning

## Gobuster

### directory enumeration

`gobuster dir -u "http://<URL>" -w /path/to/wordlist -x .php,.js`

Note that the protocol (http) must be specified.

| Flag | Description |
| ---- | ----------- |
| -u   | URL         |
| -w   | wordlist    |
| -t   | threads     |
| --delay | amount of time to wait between requests |
| -o | output results to a file |
| --no-tls-validation | skips the certificate validation, useful in CTFs |
| -c | pass a cookie |
| -x | returns specified file types along with the dirs |
| -r | follow redirects |

### subdomain enumeration

`gobuster dns -d <domain> -w /usr/share/wordlists/SecLists/Discovery/DNS/subdomains-top1million-5000.txt`

### virtual host enumeration

Enumerate different websites on the same machine.

`gobuster vhost -u "http://<ip_addr>" --domain example.com --append-domain -w <wordlist> --exclude-length 282-311`

| Flag | Description |
| ---- | ----------- |
| -u   | base url or IP |
| --domain | appends domain to each wordlist entry. Useful if base url is an IP address. Otherwise the domain is populated from the base url automatically. |
| --append-domain | appends the base domain to each word in the wordlist (e.g. word.example.com) |
| -m | specifies the HTTP method (e.g. GET, POST) |
| --exclude-length | excludes results based on the length of the response body. Useful to filter out unwanted responses like 404. |
| -r | follow redirects |