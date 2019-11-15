#!/bin/bash

# alias for using git within ~
alias hgit="git --work-tree=$HOME --git-dir=$HOME/.homer.git"

function setup_homer {
	HOMER=~/homer
	OLDWD=`pwd`
	cd ~
	for FILE in `/bin/ls -A -1 $HOMER`
	do
		if [ -e $FILE ]; then
			echo $FILE exists, backing it up to $FILE.orig
			mv $FILE $FILE.orig
		fi
		ln -s $HOMER/$FILE
	done
	cd $OLDWD
}

#echo -n 'environment, '
umask 0002 # file perms: 644 -rw-rw-r-- (755 drwxrwxr-x for dirs)
export EMAIL='just6979@gmail.com'
export PATH=$HOME/scripts:$HOME/Apps:$HOME/bin:$HOME/Apps/depot_tools:$HOME/Android/sdk/tools:$HOME/Android/sdk/platform-tools:$HOME/.gem/ruby/1.8/bin:$PATH
export EDITOR='vim'
export PAGER='less'
export LESS='-FMRs~X -x4'
export VIRTUALENV_USE_DISTRIBUTE=true
export PIP_RESPECT_VIRTUALENV=true
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export USE_CCACHE=1
export CCACHE_DIR='/temp/ccache/'


#echo -n 'bash, '
shopt -s cmdhist
shopt -s histappend
shopt -s no_empty_cmd_completion
#shopt -s nullglob

#echo -n 'prompt, '
#'user@host:cwd[err]$ '
#export PS1='\u@\h:\w/[$?]\$ ';
#export PS1='\[\e[01;32m\]\u@\h\[\e[m\]:\[\e[01;34m\]\w/\[\e[m\]\[\e[00;35m\][$?]\[\e[01;32m\]\$ \[\e[m\]'
#if [[ $TERM == 'xterm' ]]; then
#	export PS1='\[\033]0;\u@\h:\w/[$?]\$\007\]\[\e[01;32m\]\u@\h\[\e[m\]:\[\e[01;34m\]\w/\[\e[m\]\[\e[00;35m\]($?)\[\e[01;32m\]\$ \[\e[m\]'
#fi
#if [[ $TERM == 'screen' ]]; then
#	export PS1='\[\033]0;\u@\h:\w/[$?]\$\007\]\[\e[01;32m\]\u@\h\[\e[m\]:\[\e[01;34m\]\w/\[\e[m\]\[\e[00;35m\][$?]\[\e[01;32m\]\$ \[\e[m\]'
#	export PROMPT_COMMAND='echo -ne "\033k\033\\"'
#fi

#echo -n 'aliases, '
## be paranoid and prompt, unless forced with -f
alias cp='cp -ip'
alias mv='mv -i'
alias rm='rm -i'

## helpers
alias t='tail -n$LINES -f'
alias cdc='cd && clear'
alias rebash='source ~/.bashrc'
alias psfind='ps aux | grep -i'
alias jtop='htop -u justin'
# make the current shell (and its children) run IO at idle priority
#alias disknice='sudo ionice -c 3 -p $$'
alias hist='history | grep'

## quick sudos
alias svim='sudo vim'
alias sgvim='sudo gvim'
alias swpon='sudo swapon -a'
alias swpoff='sudo swapoff -a'

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
alias trd='tmux --help'
alias tx='tmux --help'

## fix sudo disabling aliases
alias sudo='sudo '

#echo -n 'ls options, '
# make ls show colors and filetype symbols
export LSCOLORS='Exfxcxdxbxegedabagacad'
# Linux uses GNU ls
if uname -a | egrep -i "linux" &> /dev/null; then
    alias ls='ls -F --color=auto';
fi
# BSDs don't
if uname -a | egrep -i "bsd" &> /dev/null; then
    alias ls='ls -F -G';
fi
# Android uses Busybox
if uname -a | egrep -i " armv7" &> /dev/null; then
    alias ls='busybox ls -F --color=auto';
    # also remove some -i prompting, busybox doesn't like them
    unalias rm
    unalias mv
fi
# raspberrypi also uses GNU ls
if uname -a | egrep -i "armv6" &> /dev/null; then
    alias ls='ls -F --color=auto';
fi

alias lsa='ls -A'
alias lss='ls -sh'
alias las='lss -A'
alias ll='ls -lh'
alias lla='ll -A'
alias lld='ll -d'

#echo -n 'shortcuts, '
alias rsync_backup='rsync -r -t -p -o -g -v --progress --delete -u -l -H -i -s -F /home/justin/'
alias rsync_personal='rsync -r -t -p -o -g -v --progress --delete -u -l -H -i -s --filter="dir-merge .rsync-prsnl-filter" /home/justin/'
alias jsh='bash -l'
alias ssh_jj='ssh justin@jester'
alias ssh_h.jw.net='ssh justin@home.justinwhite.net'

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

#echo && echo -n 'Package system... '

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
	#echo 'found Fedora base, using dnf.'
	alias pkg='dnf'
    alias spkg='sudo pkg'
    alias pkginfo='pkg info'
    alias pkglist='pkg list'
    alias pkgsearch='pkg search'
	alias pkgrefresh='spkg makecache'
	alias pkgupgrade='spkg update'
	alias pkgupgrademore='spkg upgrade'
    alias pkgclean='spkg clean all'
    alias pkgsource='spkg source'
    export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
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

alias pkginstall='spkg install'
alias pkgremove='spkg remove'
alias pkgupdate='pkgrefresh && pkgupgrade'

function pkgsort {
    pkgsearch $1 | sort;
}
function pkgless {
    pkgsearch $1 | sort | less;
}
function pkgsearchall {
    pkgsearch all $1 | less;
}

# compat
alias pkgrm='pkgremove'
alias pkgadd='pkginstall'

#echo -n 'ssh-agent, '
# reuse ssh-agent
if [ -S "$SSH_AUTH_SOCK" ] && [ ! -h "$SSH_AUTH_SOCK" ]; then
        ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
    fi
alias agent_find='export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock'
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock

alias agent_start='eval `ssh-agent`'
alias agent_kill='eval `ssh-agent -k`'

# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# VC specific aliases
alias gsmd='python ~/Code/sms/ops-tools/get_scan_metadata.py -i '

alias prod_test_net="e2e_single_seg.py -e prod -v 3 -l net -f ~/Code/sms/sms-tests/data/net/test_net.zip -p prod -c searchonsearch.cs -d App_Code.dll -r"
alias prod_test_java="e2e_single_seg.py -e prod -v 3 -l java -f ~/Code/sms/sms-tests/data/java/1.jar -p prod -r "

alias dev_test_java="e2e_single_seg.py -e dev -v 3 -l java -f ~/Code/sms/sms-tests/data/java/1.jar -p dev -r "
alias dev_test_net="e2e_single_seg.py -e dev -v 3 -l net -f ~/Code/sms/sms-tests/data/net/test_net.zip -p dev -c searchonsearch.cs -d App_Code.dll -r"

alias my_test="e2e_single_seg.py -e jwtest -v 3 -l java -f ~/Code/sms/sms-tests/data/java/1.jar -r "

source ~/scripts/gitprompt/gitprompt.sh

