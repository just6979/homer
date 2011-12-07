## .bashrc - bourne again shell startup file

#echo -n 'Setting up... '

#echo -n 'environment, '
umask 0002 # file perms: 644 -rw-rw-r-- (755 drwxrwxr-x for dirs)
export EMAIL='just6979@gmail.com'
export PATH=$PATH:$HOME/Scripts:$HOME/Apps:$HOME/bin:/usr/local/google_appengine:$HOME/src/depot_tools:$HOME/android-sdk/tools:$HOME/android-sdk/platform-tools
export EDITOR='vim'
export PAGER='less'
export LESS='-FMRs~X -x4'
export PYTHONSTARTUP=$HOME/.pythonrc
export VIRTUALENV_USE_DISTRIBUTE=true
export PIP_RESPECT_VIRTUALENV=true

#echo -n 'bash, '
#shopt -s cmdhist
#shopt -s histappend
#shopt -s no_empty_cmd_completion
#shopt -s nullglob

#echo -n 'prompt, '
#'user@host:cwd[err]$ '
#export PS1='\u@\h:\w/[$?]\$ ';
export PS1='\[\e[0;34m\]\u@\h\[\e[m\]:\[\e[0;33m\]\w/\[\e[m\]\[\e[0;35m\][$?]\[\e[1;32m\]\$ \[\e[m\]\[\e[1;37m\]'
if [[ $TERM == 'xterm' ]]; then
	export PS1='\[\033]0;\u@\h:\w/[$?]\$\007\]\[\e[0;34m\]\u@\h\[\e[m\]:\[\e[0;33m\]\w/\[\e[m\]\[\e[0;35m\]($?)\[\e[1;32m\]\$ \[\e[m\]\[\e[0;37m\]'
fi
if [[ $TERM == 'screen' ]]; then
	export PS1='\[\033]0;\u@\h:\w/[$?]\$\007\]\[\e[0;34m\]\u@\h\[\e[m\]:\[\e[0;33m\]\w/\[\e[m\]\[\e[0;35m\][$?]\[\e[1;32m\]\$ \[\e[m\]\[\e[0;37m\]'
	export PROMPT_COMMAND='echo -ne "\033k\033\\"'
fi

#echo -n 'shortcuts, '
alias rsync_backup='rsync -r -t -p -o -g -v --progress --delete -u -l -H -i -s -F /home/justin/'
alias rsync_personal='rsync -r -t -p -o -g -v --progress --delete -u -l -H -i -s --filter="dir-merge .rsync-prsnl-filter" /home/justin/'
alias sambacycle='sudo service smb restart && sudo service nmb restart'
alias jsh='bash -l'
alias sshadd='ssh-add'
alias sshjj='ssh justin@jester'
alias sshjh='ssh justin@jester.hopto.org'
function awsset {
    export AWS=$1;
}
function awsgo {
    ssh -X -i ~/.ssh/junglekeys.pem ec2-user@$AWS;
}
function awsrun {
    awsset $1;
    awsgo;
}
#be paranoid and prompt, unless forced with -f
alias cp='cp -ip'
alias mv='mv -i'
alias rm='rm -i'
# helpers
alias t='tail -n$LINES -f'
alias cdc='cd && clear'
alias rebash='source ~/.bashrc'
alias psfind='ps aux | grep -i'
# quick sudos
alias svim='sudo vim'
alias sgvim='sudo gvim'
# screen shortcuts
alias s='screen -AU'
alias sS='s -S'
alias sls='s -ls'
alias sr='s -r'
alias srd='s -rd'
alias sx='s -x'
# make ls show colors and filetype symbols
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

#echo && echo -n 'Package system... '
if [[ -e /etc/debian_version ]]; then
	#echo 'found Debian base, using apt.'
	alias service='sudo service'
	alias pkg='sudo aptitude'
    alias pkginfo='pkg show'
	alias pkgrefresh='pkg update'
	alias pkgupdate='pkg safe-upgrade'
	alias pkgupgrade='pkg full-upgrade'
fi
if [[ -e /etc/fedora-release ]]; then
	#echo 'found Fedora base, using yum.'
	alias service='sudo service'
	alias pkg='sudo yum'
    alias pkginfo='pkg info'
	alias pkgrefresh='pkg clean && pkg makecache'
	alias pkgupdate='pkg update'
	alias pkgupgrade='pkg upgrade'
fi
alias pkglist='pkg list'
alias pkgsearch='pkg search'
function pkgsearchless {
    pkgsearch $1 | less;
}
function pkgsearchsort {
    pkgsearch $1 | sort | less;
}
function pkgsearchall {
    pkgsearch all $1 | less;
}
alias pkgadd='pkg install'
alias pkgrm='pkg remove'

