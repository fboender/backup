#/bin/sh

#
# Dummy script which is an example on how to write scripts that 
# can be called by backup from the backup.list
#

DEST="$1"

mysqldump -u john -p 1234 -h localhost MyDB > $DEST/mydb.sql

