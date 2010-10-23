#!/usr/bin/env bash
# backup_media.sh - backup ~/media

source lib_backup.sh

BACKUP_DATE=`date +%Y-%m-%d_%H%M`

MACHINE=jester
ARC_DIR=${HOME}
ARC_PATH=${HOME}/backups/${MACHINE}_media_${BACKUP_DATE}.tar
ARC_FILES='Media/blends/ Media/videos/ Media/photos/'
ARC_OPTS=''

backup
echo $ARC_PATH
