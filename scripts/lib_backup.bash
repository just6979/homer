## don't use this file all alone
## set the following env-vars and source this file, then call backup()
# $ARC_DIR - directory to start in
# $ARC_PATH - archive file to create or extract from
# $ARC_FILES - the files and directories to add to extract from $ARC_PATH
# $ARC_OPTS - options passed to tar, including exclusions with '-- exclude'


# verbose, preserve-perms, sparse-efficiency, creation, show total written
backup() {
	echo ${0}: From $ARC_DIR, archiving $ARC_FILES to $ARC_PATH with tar...
	tar -C $ARC_DIR -vpc --totals $ARC_OPTS -f $ARC_PATH $ARC_FILES
	echo ${0}: Compressing $ARC_PATH with bzip2...
	bzip2 -zkfvv $ARC_PATH
	echo ${0}: Done.
}

