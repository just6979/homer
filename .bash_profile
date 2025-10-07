# .bash_profile

# load the ssh key agent
#eval `ssh-agent -s`
# load the ssh keys. ctrl-d or empty string cancels if you don't want them in memory for this session
#ssh-add

export PYENV_ROOT="$HOME/.pyenv"
if [ -f $PYENV_ROOT/bin/pyenv ]; then
	export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init --path)"
fi

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

export PATH="$HOME/.poetry/bin:$PATH"

if [ -x "$(command -v tmux)" ] && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    tmux new-session
fi

