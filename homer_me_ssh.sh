cd $HOME
git clone --bare git@github.com:just6979/homer.git .homer.git
alias git="git --work-tree=$HOME --git-dir=$HOME/.homer.git"
hgit checkout -f master
