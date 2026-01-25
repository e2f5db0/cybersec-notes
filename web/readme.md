# Pentest checklist for web

- **Automated overall rating**
    - SSL report
        - ssllabs.com/ssltest
    - Are headers set correctly?
        - securityheaders.com
    - OWASP ZAP automated test

---

- **Unsecure indexes**
    - Can you change some index or id in some url?
    - Input double parameters (only the last one may get read).

---

- **IDOR (Insecure Direct Object Reference)**
    - Can you change an id, uuid, etc. when intercepting requests which require authentication? 
    - Are users' uuids leaked by some functionality (e.g. invites) so that they don't need to be guessed?

---

- **XSS**
    - Does your input appear somewhere on the website?
    - Can you run alert(1); from some input field?

---

- **HTML injection**
    - Does any input or url parameter get reflected on the site?
    - What happens when you pass URI encoded characters?

---

- **SQLi**
    - Does your input create an SQL query?
    - Can you run your own SQL queries from the input or the url?

---

- **XML External Entities**
    - Does xml go into the server?
    - Can you insert an XXE payload and read an arbitrary file?

---

- **Broken access control**
    - Do you see something you shouldn't with your authentication level?
    - Can you perform actions which should require authentication?

---

- **Broken authentication**
    - Can you log in with common credentials?
    - Can you do credential stuffing? Is there a limit for how many username/password combinations you can brute force?
    - Do session cookies change when you log out? If not, there is a possibility for asession fixation attack.

---

- **CSRF**
    - Can you send form data to the website from your own domain?

---

- **Unchecked redirects**
    - Does some form/functionality let you redirect a victim to an arbitrary page with a parameter by csrf?

---

- **Sessions**
    - Can you manipulate or set your session id/token so that you can make a victim use it before they authenticate?
    - Do you get a useful error message on incorrect tokens (padding oracle attack)? Are HTTPOnly and Secure flags set for session cookies?

---

- **File handling**
    - Does the website retain the original filename after upload?
    - Can you show arbitrary files? Can you fetch arbitrary files into the frontend?

---

- **XXE**
    - Is some XML sent to the server?
    - Can you make requests to arbitrary URIs from the XML Entities?

---

- **Static code analysis**
    - Check the browser devtools.
        - What XHR API calls are made?
    - Analyse the files with Debugger & Console.
        - Do any .js files contain cleartext tokens, credentials or database addresses?

---

- **Subdomain takeover**
    - Check DNS records for unclaimed subdomains.
        - site:*hackerone.com (Google Dorks)
        - crt.sh
        - KnockPy
        - Recon-ng

---