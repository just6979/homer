## .bashrc - bourne again shell startup file

#VBox workaround
#export VBOX_HWVIRTEX_IGNORE_SVM_IN_USE=true

# useful bash options
shopt -s cmdhist
shopt -s histappend
shopt -s no_empty_cmd_completion
shopt -s nullglob

## file permissions: 644 -rw-rw-r-- (755 drwxrwxr-x for dirs)
umask	0002

# environment
export EMAIL='just6979@gmail.com'
export PATH=$PATH:$HOME/scripts
export EDITOR='vim'
export PAGER='less'
export LESS='-FMRs~X -x4'
export PYTHONSTARTUP=$HOME/.pythonrc

# be paranoid and prompt, unless forced with -f
alias cp='cp -ip'
alias mv='mv -i'
alias rm='rm -i'

# single shots
alias t='tail -n$LINES -f'

# helpers
alias cdc='cd && clear'
alias rebash='source ~/.bashrc'
alias findproc='ps aux | grep -i'

# quick sudos
alias svim='sudo vim'
alias sgvim='sudo gvim'
alias suwww='sudo -u www'
alias skate='sudo kate'

# screen shortcuts
alias s='screen -U'
alias sS='screen -US'
alias sls='s -ls'
alias sr='s -r'
alias sx='s -x'

OE='fedora'
if [[ $OE == 'debian' ]]; then
	alias pkg='sudo aptitude'
	alias service='sudo invoke-rc.d'
	alias pkgupgrade='pkg safe-upgrade full-upgrade'
fi
if [[ $OE == 'fedora' ]]; then
	alias pkg='sudo yum'
	alias service='sudo service'
	alias pkgupgrade='pkg upgrade'
fi
alias pkgadd='pkg install'
alias pkgrm='pkg remove'
alias pkgfind='pkg search'
alias pkginfo='pkg info'
alias pkgupdate='pkg update'

## make ls show colors and filetype symbols
export LSCOLORS='Exfxcxdxbxegedabagacad'
if uname -a | egrep "BSD" &> /dev/null; then
	alias ls='ls -Fh -G';
else
	alias ls='ls -Fh --color=auto';
fi
alias lsa='ls -a'
alias ll='ls -l'
alias lla='ll -a'
alias lld='ll -d'

## set prompt: 'user@host:cwd[err]$ '
#export PS1='\u@\h:\w/[$?]\$ ';
export PS1='\[\e[0;34m\]\u@\h\[\e[m\]:\[\e[0;33m\]\w/\[\e[m\]\[\e[0;35m\][$?]\[\e[1;32m\]\$ \[\e[m\]\[\e[1;37m\]'
if [[ $TERM == 'xterm' ]]; then
	export PS1='\[\033]0;\u@\h:\w/[$?]\$\007\]\[\e[0;34m\]\u@\h\[\e[m\]:\[\e[0;33m\]\w/\[\e[m\]\[\e[0;35m\]($?)\[\e[1;32m\]\$ \[\e[m\]\[\e[0;37m\]'
fi
if [[ $TERM == 'screen' ]]; then
	export PS1='\[\033]0;\u@\h:\w/[$?]\$\007\]\[\e[0;34m\]\u@\h\[\e[m\]:\[\e[0;33m\]\w/\[\e[m\]\[\e[0;35m\][$?]\[\e[1;32m\]\$ \[\e[m\]\[\e[0;37m\]'
	export PROMPT_COMMAND='echo -ne "\033k\033\\"'
fi

# keychain shortcuts
function kc_find() { eval `keychain --eval --quiet --quick`; }
function kc_load() { eval `keychain --eval --ignore-missing id_rsa id_dsa identity`; }
function kc_kill() { keychain --stop all; }

#kc_find
