#!/usr/bin/env bash
# backup_home.sh - backup selected files in ~

source lib_backup.sh

BACKUP_DATE=`date +%Y-%m-%d-%H%M`

MACHINE=jester
ARC_DIR=${HOME}
ARC_PATH=${HOME}/Backups/${MACHINE}_home_${BACKUP_DATE}.tar
ARC_FILES='local/ Code/ Misc/ School/'
ARC_OPTS=''

backup

