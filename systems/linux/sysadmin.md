# Linux sysadmin / blue team notes

```bash
# Monitor log files
tail -F /var/log/auth.log /var/log/syslog /var/log/snort/snort.alert.fast

# See old compressed logs
zcat /var/log/auth.log.1.gz | less
```