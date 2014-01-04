#!/bin/bash

function setup_homer {
	HOMER=~/homer
	OLDWD=`pwd`
	cd ~
	for FILE in `/bin/ls -A -1 $HOMER`
	do
		if [ -e $FILE ]; then
			echo $FILE exists, backing it up to $FILE.orig
			mv $FILE $FILE.orig
		fi
		ln -s $HOMER/$FILE
	done
	cd $OLDWD
}

source ~/.bash.d/env.sh
source ~/.bash.d/prompt.sh
source ~/.bash.d/alias.sh
source ~/.bash.d/ls.sh
source ~/.bash.d/shortcuts.sh
source ~/.bash.d/pkg.sh
source ~/.bash.d/cm.sh
