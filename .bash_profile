# .bash_profile

LOAD_SSH_KEYS=0
if [[ $LOAD_SSH_KEYS -eq 1 ]]; then
    # load the ssh key agent
    eval `ssh-agent -s`
    # load the ssh keys. ctrl-d or empty string cancels if you don't want them in memory for this session
    ssh-add
fi

export PYENV_ROOT="$HOME/.pyenv"
if [ -f $PYENV_ROOT/bin/pyenv ]; then
	export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init --path)"
fi

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

START_TMUX=0
if [[ $START_TMUX -eq 1 ]]; then
    if [ -x "$(command -v tmux)" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]]; then
        tmux new-session
    fi
fi

