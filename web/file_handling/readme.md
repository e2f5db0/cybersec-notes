# Notes on file handling

## Null termination bugs
When testing file handling vulns on php (example):

```
<?php
include($GET['page'] . ['.php']);
?>
```

Try to include null character %00 or \x00 to exclude the file extension. This may allow reading arbitrary files like this:

?page=/etc/passwd%00

---

## XXE

When a file gets uploaded to some server, chances are there is XML in it. This opens the possibility for XXE attacks.

---