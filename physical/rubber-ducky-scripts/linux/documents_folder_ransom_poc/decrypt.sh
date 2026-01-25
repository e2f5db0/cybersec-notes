#!/bin/bash
wget https://paste.c-net.org/LoweredOught
mv LoweredOught private.pgp
gpg --import private.pgp
gpg --decrypt Documents.tar.gz.gpg > Documents.tar.gz
tar -xzf Documents.tar.gz Documents
rm private.pgp Documents.tar.gz Documents.tar.gz.gpg encrypt.sh demand
gsettings set org.gnome.desktop.background picture-uri /usr/share/backgrounds/warty-final-ubuntu.png
