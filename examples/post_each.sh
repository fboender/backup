#!/bin/sh

/usr/bin/gpg --batch --yes -e -r "Ferry Boender" ${DEST_DIR}${DEST_FILE}
/usr/bin/wipe -q -Q1 -f -s ${DEST_DIR}${DEST_FILE}
