#!/bin/sh
#
# script.sh
#
# Backup example script for Script directives. 
#
# This script gets one parameter, which is the destination directory to which
# to save the files you want backed up.  It then copies or creates files in
# that directory. In this case it creates MySQL dumps from a database. The
# directory will then be backed up by Backup under the full name of the script
# (i.e. /usr/local/bin/script.sh will become usr.local.bin.mysql.sh.tar.bz2)
# unless you echo something in this script. In that case, the text you echo
# will become the filename, with .tar.bz2 appended.
#

DEST="$1"

USERNAME="todsah"
PASSWD=""

MYSQL_CMD="mysql -u $USERNAME -p$PASSWD -h localhost -N --batch -e "
MYSQLDUMP_CMD="mysqldump -u $USERNAME -p$PASSWD -h localhost "

$MYSQL_CMD "SHOW DATABASES" | grep -v "svcmon" | while read TBL; do
    $MYSQLDUMP_CMD $TBL | gzip -9 - > $DEST/$TBL.sql.gz
done

echo "mysql"

