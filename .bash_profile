# .bash_profile

# load the ssh key agent
eval `ssh-agent -s`
# load the ssh keys. ctrl-d or empty string cancels if you don't want them in memory for this session
ssh-add

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
