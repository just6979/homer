#!/usr/bin/env bash
# backup_www.sh - backup website root, including virtual host configuration

source lib_backup.sh

BACKUP_DATE=`date +%Y-%m-%d-%H%M`

MACHINE=jester
ARC_DIR=${HOME}
ARC_PATH=${HOME}/Backups/${MACHINE}_www_${BACKUP_DATE}.tar
ARC_FILES='/home/www/htdocs/ /home/www/trac/'
ARC_OPTS=''

backup

