#!/bin/sh
#
# include.sh
#
# Backup example script for Include directives. 
#
# This script outputs a bunch of other directives (exclude 'include'
# directives) which will be backed up like any normally supplied directive.
#

for DIR in `find /home/ -maxdepth 1 -type d | grep -v "^/home/$" | grep -v "/home/todsah" `; do
    echo "D:$DIR"
done

