#!/bin/bash

#echo -n 'environment, '
umask 0002 # file perms: 644 -rw-rw-r-- (755 drwxrwxr-x for dirs)
export EMAIL='just6979@gmail.com'
export PATH=$PATH:$HOME/scripts:$HOME/Apps:$HOME/bin:$HOME/Apps/depot_tools:$HOME/Android/sdk/tools:$HOME/Android/sdk/platform-tools:$HOME/.gem/ruby/1.8/bin
export EDITOR='vim'
export PAGER='less'
export LESS='-FMRs~X -x4'
export PYTHONSTARTUP=$HOME/.pythonrc
export VIRTUALENV_USE_DISTRIBUTE=true
export PIP_RESPECT_VIRTUALENV=true
export USE_CCACHE=1
export CCACHE_DIR='/home/justin/tmp/ccache/'


#echo -n 'bash, '
shopt -s cmdhist
shopt -s histappend
shopt -s no_empty_cmd_completion
shopt -s nullglob
