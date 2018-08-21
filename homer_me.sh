cd $HOME
git clone --bare https://github.com/just6979/homer.git .homer.git
alias hgit="git --work-tree=$HOME --git-dir=$HOME/.homer.git"
homegit checkout -f master
