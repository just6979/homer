## .profile - bourne shell login file
## this file gets read only for login shells

## get aliases and such
if [ -r ~/.bashrc ]; then
	source ~/.bashrc
fi

## some information
PLATFORM=`uname -srm`
HOST=`hostname`
#USER=`whoami`

## where am i?
echo Hello $USER. Welcome to $HOST running $PLATFORM

# check and load private keys with keychain
#eval `keychain --eval --ignore-missing id_rsa id_dsa identity`

fortune | cowsay

