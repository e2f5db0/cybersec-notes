# Notes on csrf

## What is it?

A cross-site request forgery attack happens when a victim is tricked into loading a page including a hidden form which sends some data to another server. If a victim is authenticated to some service then the request is valid and goes through even if it originated from the hacker's unrelated website. If the hidden form is for example a copy of the service's real form for changing a user's password then the victim gets their password changed by visiting a completely different site without realising what just happened.

## How to detect the vuln

- If a form doesn't include a csrf token, the website is probably vulnerable to csrf attacks.
- If a form has a csrf token but the token is created on the client side then valid tokens can be created by the hacker as well.

---