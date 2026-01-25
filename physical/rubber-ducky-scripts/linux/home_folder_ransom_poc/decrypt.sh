#!/bin/bash
cd
user=$(whoami)
gpg --decrypt .$user.tar.gz.gpg > $user.tar.gz
tar -xzf $user.tar.gz .
rm demand
gsettings set org.gnome.desktop.background picture-uri /usr/share/backgrounds/warty-final-ubuntu.png
