#!/bin/bash

# make ls show colors and filetype symbols
export LSCOLORS='Exfxcxdxbxegedabagacad'
# Linux uses GNU ls
if uname -a | egrep -i "linux" &> /dev/null; then
    alias ls='ls -Fh --color=auto';
fi
# BSDs don't
if uname -a | egrep -i "bsd" &> /dev/null; then
    alias ls='ls -Fh -G';
fi
# Android uses Busybox
if uname -a | egrep -i " armv7" &> /dev/null; then
    alias ls='busybox ls -Fh --color=auto';
    # also remove some -i prompting, busybox doesn't like them
    unalias rm
    unalias mv
fi
# raspberrypi also uses GNU ls
if uname -a | egrep -i "armv6" &> /dev/null; then
    alias ls='ls -Fh --color=auto';
fi

alias lsa='ls -a'
alias ll='ls -l'
alias lla='ll -a'
alias lld='ll -d'
