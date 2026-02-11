#!/bin/bash

# alias for using git within ~
alias hgit='git --work-tree=$HOME --git-dir=$HOME/.homer.git'
alias lazyhgit='lazygit --work-tree=$HOME --git-dir=$HOME/.homer.git'

setup_homer() {
	HOMER=~/homer
	OLDWD=$(pwd)
	cd ~ || exit
	for FILE in $(/bin/ls -A -1 $HOMER)
	do
		if [ -e "$FILE" ]; then
			echo "$FILE exists, backing it up to $FILE.orig"
			mv "$FILE" "$FILE".orig
		fi
		ln -s $HOMER/"$FILE"
	done
	cd "$OLDWD" || exit
}

# disable ctrl-s/q freezing terminal
stty -ixon

if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
fi

# prefs and settings
umask 0002 # file perms: 644 -rw-rw-r-- (755 drwxrwxr-x for dirs)
export EMAIL='just6979@gmail.com'
export PATH=$HOME/.local/bin:$HOME/scripts:$HOME/Apps:$HOME/bin:$PATH
export EDITOR='vim'
if [[ -x $(type -P nvim) ]]; then
	export EDITOR='nvim'
	alias vim='nvim'
fi
export PAGER='less'
export LESS='-FMRs~X -x4'
export VIRTUALENV_USE_DISTRIBUTE=true
export PIP_RESPECT_VIRTUALENV=true
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3

shopt -s cmdhist
shopt -s histappend
shopt -s histverify
export HISTFILESIZE=1000000
export HISTSIZE=1000000
export HISTCONTROL=ignoredups
export HISTIGNORE='bg:fg:history'

shopt -s no_empty_cmd_completion
shopt -s nullglob
shopt -s cdspell
shopt -s dirspell

#'user@host:cwd[err]$ '
#export PS1='\u@\h:\w/[$?]\$ ';
export PS1='\[\e[01;32m\]\u@\h\[\e[m\]:\[\e[01;34m\]\w/\[\e[m\]\[\e[00;35m\][$?]\[\e[01;32m\]\$ \[\e[m\]'

if [[ $TERM == 'tmux-256color' ]]; then
	export PS1='\[\033]0;\u@\h:\w/[$?]\$\007\]\[\e[01;32m\]\u@\h\[\e[m\]:\[\e[01;34m\]\w/\[\e[m\]\[\e[00;35m\]($?)\[\e[01;32m\]\$ \[\e[m\]'
fi

if [[ $TERM == 'xterm' ]]; then
	export PS1='\[\033]0;\u@\h:\w/[$?]\$\007\]\[\e[01;32m\]\u@\h\[\e[m\]:\[\e[01;34m\]\w/\[\e[m\]\[\e[00;35m\]($?)\[\e[01;32m\]\$ \[\e[m\]'
fi

if [[ $TERM == 'screen' ]]; then
	export PS1='\[\033]0;\u@\h:\w/[$?]\$\007\]\[\e[01;32m\]\u@\h\[\e[m\]:\[\e[01;34m\]\w/\[\e[m\]\[\e[00;35m\][$?]\[\e[01;32m\]\$ \[\e[m\]'
	export PROMPT_COMMAND='echo -ne "\033k\033\\"'
fi

export PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

## be paranoid and prompt, unless forced with -f
alias cp='cp -ip'
alias mv='mv -i'
alias rm='rm -i'

## helpers
alias powstat="sudo turbostat -s PkgTmp,CorWatt,GFXWatt,PkgWatt,RAMWatt,SysWatt -i 2"
alias batstat="upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -e energy-rate -e state"
alias t='tail -n$LINES -f'
alias cdc='cd && clear'
alias rebash='source ~/.bashrc'
alias psfind='ps aux | grep -i'
alias jtop='htop -u justin'
# make the current shell (and its children) run IO at idle priority
#alias disknice='sudo ionice -c 3 -p $$'
hist() { history | grep "$@"; }

## nearlyfreespeech.net shortcuts
alias nfs_ssh='ssh just6979_justinwhite@ssh.nyc1.nearlyfreespeech.net'

## screen shortcuts
alias s='screen -AOUR'
alias sS='s -S'
alias sls='s -ls'
alias sr='s -r'
alias srd='s -rd'
alias sx='s -x'

## tmux shortcuts
alias t='tmux'
alias tS='tmux new -s'
alias tls='tmux list-sessions'
alias ta='tmux attach-session'
alias tks='tmux kill-session -a'
alias trd='tmux --help'
alias tx='tmux --help'

## docker helpers
docker-build-latest-tag() { docker build -t "$1":latest -t "$1":"$(git rev-parse --short HEAD)" .; }

# make ls show colors and filetype symbols
export LSCOLORS='Exfxcxdxbxegedabagacad'
# Linux uses GNU ls
if uname -a | grep -E -i "linux" &> /dev/null; then
    alias ls='ls -F --color=auto';
fi
# BSDs don't
if uname -a | grep -E -i "bsd" &> /dev/null; then
    alias ls='ls -F -G';
fi
# Android uses Busybox
if uname -a | grep -E -i " armv7" &> /dev/null; then
    alias ls='busybox ls -F --color=auto';
    # also remove some -i prompting, busybox doesn't like them
    unalias rm
    unalias mv
fi
# raspberrypi also uses GNU ls
if uname -a | grep -E -i "armv6" &> /dev/null; then
    alias ls='ls -F --color=auto';
fi

alias lsa='ls -A'
alias lss='ls -sh'
alias las='lss -A'
alias ll='ls -lh'
alias lla='ll -A'
alias lld='ll -d'


if [[ -e /etc/debian_version ]]; then
	#echo 'found Debian base, using apt.'
    if [[ -e /usr/bin/aptitude ]]; then
        alias pkg='aptitude -V'
        alias pkg2='aptitude -V'
        alias pkgclean='spkg autoclean; spkg clean; spkg purge ~c'
    else
        alias pkg='apt'
        alias pkg2='apt-cache'
        alias pkgclean='spkg autoremove; spkg autoclean; spkg clean'
    fi
    alias spkg='sudo pkg'
	alias pkginfo='pkg2 show'
	alias pkglist='pkg2 pkgnames'
	alias pkgsearch='pkg2 search'
    alias pkgpurge='spkg purge'
	alias pkgrefresh='spkg update'
	alias pkgupgrade='spkg -V upgrade'
	alias pkgupgrademore='spkg dist-upgrade -V'
	alias pkgsource='spkg source'
fi

if [[ -e /etc/fedora-release ]]; then
	#echo 'found F'edora base, using dnf.'
	pkg() { dnf "$@"; }
	spkg() { sudo dnf "$@"; }
    pkginfo() { pkg info "$@"; }
    pkglist() { pkg list "$@"; }
    pkgsearch() { pkg search "$@"; }
    pkgprovides() { pkg provides "$@"; }
	alias pkgrefresh='spkg makecache'
	alias pkgupgrade='spkg upgrade'
    alias pkgclean='spkg clean all'
fi

if [[ -e /etc/centos-release ]]; then
	#echo 'found CentOS base, using yum.'
	alias pkg='yum'
    alias spkg='sudo pkg'
    alias pkginfo='pkg info'
    alias pkglist='pkg list'
    alias pkgsearch='pkg search'
	alias pkgrefresh='spkg makecache'
	alias pkgupgrade='spkg update'
	alias pkgupgrademore='spkg upgrade'
    alias pkgclean='spkg clean all'
    alias pkgsource='spkg source'
fi

# non-distro-specific packagin shortcuts
pkginstall() { spkg install "$@"; }
pkgremove() { spkg remove "$@"; }
pkgadd() { spkg install "$@"; }
pkgrm() { spkg remove "$@"; }
alias pkgupdate='pkgrefresh && pkgupgrade'
pkgsort() { pkgsearch "$@" | sort; }
pkgless() { pkgsearch "$@" | sort | less; }

# reuse ssh-agent
#if [ -S "$SSH_AUTH_SOCK" ] && [ ! -h "$SSH_AUTH_SOCK" ]; then
#        ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
#    fi
#alias agent_find='export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock'
#export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
#alias agent_start='eval `ssh-agent`'
#alias agent_kill='eval `ssh-agent -k`'

if [[ -d $PYENV_ROOT/bin ]]; then
    eval "$(pyenv virtualenv-init -)"
fi

export PATH=$PATH:/home/jwhite/.local/bin

# complete -C /usr/bin/terraform terraform
# export PATH="$HOME/.tfenv/bin:$PATH"

USE_STARSHIP=1
if [[ $USE_STARSHIP -eq 1 ]]; then
    if [ -f /usr/local/bin/starship ]; then eval -- "$(/usr/local/bin/starship init bash --print-full-init)"; fi
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ -f "$HOME/.cargo/env" ]; then . "$HOME/.cargo/env"; fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/justin/google-cloud-sdk/path.bash.inc' ]; then . '/home/justin/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/justin/google-cloud-sdk/completion.bash.inc' ]; then . '/home/justin/google-cloud-sdk/completion.bash.inc'; fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# fnm
FNM_PATH="/home/justin/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env)"
fi
