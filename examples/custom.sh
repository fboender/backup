#!/bin/sh
#
# custom.sh
#
# Backup example script for Custom directives. 
#
# This script gets one parameter, which is the destination directory to which
# to save the backup files you want backed up. The main Backup script does
# nothing else for you, except run the POST script on the final backups.
#

DEST="$1"
USERNAME="todsah"
PASSWD=""

MYSQL_CMD="mysql -u $USERNAME -p$PASSWD -h localhost -N --batch -e "
MYSQLDUMP_CMD="mysqldump -u $USERNAME -p$PASSWD -h localhost "

$MYSQL_CMD "SHOW DATABASES" | grep -v "svcmon" | while read TBL; do
    $MYSQLDUMP_CMD $TBL | gzip -9 - > $DEST/$TBL.sql.gz
done

