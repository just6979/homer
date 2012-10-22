#!/bin/bash

#be paranoid and prompt, unless forced with -f
alias cp='cp -ip'
alias mv='mv -i'
alias rm='rm -i'

# helpers
alias t='tail -n$LINES -f'
alias cdc='cd && clear'
alias rebash='source ~/.bashrc'
alias psfind='ps aux | grep -i'
alias jtop='htop -u justin'

# quick sudos
alias svim='sudo vim'
alias sgvim='sudo gvim'
alias swpon='sudo swapon -a'
alias swpoff='sudo swapoff -a'

# screen shortcuts
alias s='screen -AOU'
alias sS='s -S'
alias sls='s -ls'
alias sr='s -r'
alias srd='s -rd'
alias sx='s -x'
