#!/bin/bash

# reuse ssh-agent
if [ -S "$SSH_AUTH_SOCK" ] && [ ! -h "$SSH_AUTH_SOCK" ]; then
        ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
    fi
alias agent_find='export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock'
agent_find

alias agent_start='eval `ssh-agent`'
alias agent_kill='eval `ssh-agent -k`'
alias agent_load_dvcs='ssh-add ~/.ssh/dvcs_id_dsa'
