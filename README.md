homer
=====

Run the follow commands in your $HOME to get all the configs.

cd $HOME
git clone --bare https://github.com/just6979/homer.git .homer.git
alias homegit="git --work-tree=$HOME --git-dir=$HOME/.homer.git"
homegit checkout -f master

