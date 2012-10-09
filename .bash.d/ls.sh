#!/bin/bash

# make ls show colors and filetype symbols
export LSCOLORS='Exfxcxdxbxegedabagacad'
if uname -a | egrep -i "linux" &> /dev/null; then
    alias ls='ls -Fh --color=auto';
fi
if uname -a | egrep -i "bsd" &> /dev/null; then
    alias ls='ls -Fh -G';
fi
if uname -a | egrep -i " arm" &> /dev/null; then
    alias ls='busybox ls -Fh --color=auto';
    # also remove some -i prompting, busybox doesn't like them
    unalias rm
    unalias mv
fi
alias lsa='ls -a'
alias ll='ls -l'
alias lla='ll -a'
alias lld='ll -d'
