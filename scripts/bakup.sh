# use rsync to syncronize a directory using the exclusion file (a list of globs) in the source directory
#!/bin/sh

rsync -vauSihhP --delete --stats --exclude-from=$1/.bakup.exclude $1 $2

