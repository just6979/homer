# .bash_profile

# load the ssh key agent
eval `ssh-agent -s`
# load the ssh keys. ctrl-d or empty string cancels if you don't want them in memory for this session
ssh-add

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

source /home/jwhite/scripts/gitprompt/gitprompt.sh

# centos
if [[ -e /usr/bin/virtualenvwrapper.sh ]]; then
    source /usr/bin/virtualenvwrapper.sh
fi

# fedora
if [[ -e /usr/local/bin/virtualenvwrapper_lazy.sh ]]; then
    source /usr/local/bin/virtualenvwrapper_lazy.sh
fi

# ubuntu
if [[ -e /usr/share/virtualenvwrapper/virtualenvwrapper.sh ]]; then
    source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
fi

# WSL
if [[ -e /usr/bin/wslsys ]]; then
    echo "Found WSL, enabling screen"
    sudo mkdir -pm 777 /run/screen
fi

# if $STY is not set...
if [ -z "$STY" ]; then
    screen -ARR
fi

