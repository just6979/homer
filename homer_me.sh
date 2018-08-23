cd $HOME
git clone --bare $1 .homer.git
alias hgit="git --work-tree=$HOME --git-dir=$HOME/.homer.git"
hgit checkout -f master
