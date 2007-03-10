#!/bin/sh

DEST="$1"
USERNAME=`grep "^user" /etc/mysql/debian.cnf | head -1 | cut -d"=" -f2 | sed -e "s/^\s\(.*\)\s*$/\1/g"`
PASSWORD=`grep "^password" /etc/mysql/debian.cnf | head -1 | cut -d"=" -f2 | sed -e "s/^\s\(.*\)\s*$/\1/g"`

if [ -z "$1" ]; then
    echo "Usage: $0 path_to_store"
    exit
fi
if [ -z "$USERNAME" ]; then
    echo "No username found. Aborting.."
    exit
fi
if [ -z "$PASSWORD" ]; then
    echo "No password found. Aborting.."
    exit
fi

MYSQL_CMD="mysql -u $USERNAME -p$PASSWORD -h localhost -N --batch -e "
MYSQLDUMP_CMD="mysqldump --routines=true --triggers=true --complete-insert -u $USERNAME -p$PASSWORD -h localhost "

$MYSQL_CMD "SHOW DATABASES" | while read TBL; do
    $MYSQLDUMP_CMD $TBL | gzip -9 - > $DEST/$TBL.sql.gz
done
