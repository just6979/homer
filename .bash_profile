# .bash_profile

# load the ssh key agent
eval `ssh-agent -s`

# load the ssh keys. ctrl-d or empty string cancels if you don't want them in memory for this session
#ssh-add

# echo -n 'keychain, '
#function kc_find() { eval `keychain --eval --quiet --quick`; }
#function kc_load() { eval `keychain --eval --ignore-missing id_rsa id_dsa      identity`; }
#function kc_kill() { keychain --stop all; }
#kc_find

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

cd
