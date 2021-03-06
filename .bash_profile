# .bash_profile

# load the ssh key agent
eval `ssh-agent -s`
# load the ssh keys. ctrl-d or empty string cancels if you don't want them in memory for this session
ssh-add

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# WSL
if [[ -e /usr/bin/wslsys ]]; then
    if [[ ! -d /run/screen ]]; then
        echo "Found WSL, enabling screen"
        sudo mkdir -pm 777 /run/screen
    fi
fi

# if $STY is not set...
if [ -z "$STY" ]; then
    screen -ARR
fi

# MacPorts Installer addition on 2019-04-08_at_22:54:40: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

