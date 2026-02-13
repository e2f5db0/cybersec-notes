# Notes on web hacking

## Curl

Basic usage:

```bash
# HEAD request
$ curl -I https://example.com/api/resource

# GET request
$ curl https://example.com/api/resource

# send POST request with JSON data
$ curl -X POST https://example.com/api/resource -H "Content-Type: application/json" -d '{"key1":"value1", "key2":"value2"}'

# spoof iPhone User-Agent header to a backend server
$ curl -H "User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 15_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.5 Mobile/15E148 Safari/604.1" http://unsecure-app.com:5005/

# spoof android User-Agent header to a backend server
$ curl -H "User-Agent: Mozilla/5.0 (Linux; Android 12; Pixel 5 Build/SQ1A.211205.016) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Mobile Safari/537.36" http://unsecure-app.com:5005/
```