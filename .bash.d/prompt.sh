#!/bin/bash

#echo -n 'prompt, '
#'user@host:cwd[err]$ '
#export PS1='\u@\h:\w/[$?]\$ ';
export PS1='\[\e[01;32m\]\u@\h\[\e[m\]:\[\e[01;34m\]\w/\[\e[m\]\[\e[00;35m\][$?]\[\e[01;32m\]\$ \[\e[m\]\[\e[01;37m\]'
if [[ $TERM == 'xterm' ]]; then
	export PS1='\[\033]0;\u@\h:\w/[$?]\$\007\]\[\e[01;32m\]\u@\h\[\e[m\]:\[\e[01;34m\]\w/\[\e[m\]\[\e[00;35m\]($?)\[\e[01;32m\]\$ \[\e[m\]\[\e[00;37m\]'
fi
if [[ $TERM == 'screen' ]]; then
	export PS1='\[\033]0;\u@\h:\w/[$?]\$\007\]\[\e[01;32m\]\u@\h\[\e[m\]:\[\e[01;34m\]\w/\[\e[m\]\[\e[00;35m\][$?]\[\e[01;32m\]\$ \[\e[m\]\[\e[01;37m\]'
	export PROMPT_COMMAND='echo -ne "\033k\033\\"'
fi
