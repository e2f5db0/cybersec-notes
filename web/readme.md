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
```